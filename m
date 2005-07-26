Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262204AbVGZWS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbVGZWS1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 18:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbVGZWS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 18:18:26 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:44499 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262212AbVGZWRA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 18:17:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uAZ8Fqr4Bij+xTMQR93Br1t8f239d4JYypgjTTOdNrM+fTg8g2iPQPFbOtoza58dnlh3VEbaJkQ0XXiBx3UAA2JFLhm9pBaoBsOpH5vDywYFFu0xcYAwS1T9F29S5HUn7nTYEVjXIdVJUqdD46yI/1WeAkwmnkSlfrA99V2zsog=
Message-ID: <4746469c05072615167ca234ce@mail.gmail.com>
Date: Tue, 26 Jul 2005 15:16:58 -0700
From: Mike Mohr <akihana@gmail.com>
Reply-To: Mike Mohr <akihana@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Reclaim space from unused ramdisk?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if it would be possible to somehow reclaim space that has
been previously reserved for a ramdisk without rebooting.  I read the
ramdisk docs in the latest kernel source and it seems that it is not
currently possible.  However, the kernel keeps track of the memory
allocated for said ramdisks; would it not be possible with root (or
even kernel) permissions to remove the flag that prevents the VM
subsystem from reclaiming that space?  I realize that rot permissions
may not be high enough.  In that case, could a module be written that
takes a device name as a parameter then uses it to look up the
reserved memory that device uses, then resets the necessary flag and
finally unloads itself?  It would have to check that the filesystem
was unmounted, of course.

How difficult would this be to write?
