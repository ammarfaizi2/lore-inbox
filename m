Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbVJJERN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbVJJERN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 00:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbVJJERN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 00:17:13 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:24920 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932337AbVJJERN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 00:17:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UVhy9d0bSqYSe9KZ9Lz2Py+wNIWwxe4ubU5pe5p99VNLDBEVjsEbmlOMdv0zwM44987DlXnZzPqcvWI1KOVRc/Zkzj9hyu4/4L4uTM3863uxbQtgxqSBPt7LdKO7iOhR2N9rnqCt+tRalmOBWLcd8MW8TxIFo8uJ5z0tZNf2olE=
Message-ID: <3ad486780510092117x1796d8f6m9d1ef4c2dbc56d17@mail.gmail.com>
Date: Mon, 10 Oct 2005 14:17:12 +1000
From: spereira <pereira.shaun@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: 32 bit (socket layer) ioctl emulation for 64 bit kernels
In-Reply-To: <3ad486780510092112r518295a5pebc3441674cbae4d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3ad486780510092112r518295a5pebc3441674cbae4d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I am trying to implement 32 bit userland support for existing x25
socket layer ioctls in a x86_64 kernel for use in a project for a
telco.

 It used to be possible to extend the  contents of the
ioctl32_hash_table(fs/compat.c) for ioctl commands and associated
handlers (= 64 bit converstion functions) by calling the
register_ioctl32_conversion() function.
However this function has now been scheduled for removal. The
suggested replacement seems to be available only for inode structures
created for "actual" file systems, where the i_fop points to
operations for "real" files. When using "socket type" inodes
i_fop(inode/fs.h) points to operations for sockets which does not
provide a hook like compat_ioctl for handling such conversions.

Is there currently an alternative to register_ioctl32_conversion that
would help achive 32 bit ioctl emulation at the socket layer?
Any suggestions/advice whould be much appreciated.
Many Thanks
Shaun
