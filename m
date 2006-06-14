Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWFNUZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWFNUZE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 16:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWFNUZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 16:25:04 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:8122 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751145AbWFNUZC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 16:25:02 -0400
Date: Wed, 14 Jun 2006 22:24:26 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: =?iso-8859-1?q?Pablo=20Barb=E1chano?= <pablobarbachano@yahoo.es>
cc: 7eggert@gmx.de, linux-kernel@vger.kernel.org
Subject: Re: loop devices removable
In-Reply-To: <20060614152232.17933.qmail@web26012.mail.ukl.yahoo.com>
Message-ID: <Pine.LNX.4.58.0606142117001.16397@be1.lrz>
References: <20060614152232.17933.qmail@web26012.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2006, Pablo Barbáchano wrote:
>  --- Bodo Eggert <7eggert@elstempel.de> escribió:
> > Pablo Barbachano <pablobarbachano@yahoo.es> wrote:

> > [loop devices]
> > 
> > > The (probably broken) reason I want to do that is so I can use (my
> > > modified) pmount to mount them.
> > 
> > I'm wondering if fuse would be suited better. I did not yet experiment
> > with that, but it seems it has everything you need.
> 
> There is something based on FUSE:
> http://lwn.net/Articles/173617/
> 
> Which involves UML... doesn't seem a good option to me...

I just tried it out, and fuse/uml seems it works out-of-the-box (using a
simple mount-like command) while preventing the user from crashing the
kernel "using" a corrupt fs image. If you rename the mountlo program to 
"mount" and put it un the user's path, they won't notice they're using 
fuse at all, except for not honoring fstab. (Off cause /sbin must come 
before /usr/local/bin in root's path!)

-- 
Top 100 things you don't want the sysadmin to say:
39. It is only a minor upgrade, the system should be back up in
    a few hours.  ( This is said on a monday afternoon.)
