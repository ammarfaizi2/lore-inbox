Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVJJEVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVJJEVc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 00:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbVJJEVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 00:21:32 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:8587 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932341AbVJJEVb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 00:21:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YzUn29eUGlMqfCmL+6QzFSP4QbXbJlc9jcZQuK+KwRlv31eQlJARM4OoP9p/f8FgFKPfad28+Y2tI/6Ez70+LCYtsQVfdAtXALGqIgzoM4twjKOD2NS7N6YbN++ho+Byr+YakUZJoiEeSKuom1uMQC+VSlcxrjSQ4HyEt2mqdnA=
Message-ID: <3ad486780510092121h78a522cat11f33581dfc670dc@mail.gmail.com>
Date: Mon, 10 Oct 2005 14:21:31 +1000
From: spereira <pereira.shaun@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 32 bit (socket layer) ioctl emulation for 64 bit kernels- Question regarding...
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
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
