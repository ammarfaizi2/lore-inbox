Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWFUQQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWFUQQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWFUQQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:16:29 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:484 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S932214AbWFUQQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:16:28 -0400
Date: Wed, 21 Jun 2006 18:16:03 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: 7eggert@gmx.de, andi@lisas.de, Andrew Morton <akpm@osdl.org>,
       gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, hal@lists.freedesktop.org
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner
 underruns, USB HDD hard resets)
In-Reply-To: <1150887236.15275.37.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0606211802590.3817@be1.lrz>
References: <6pnj7-32Q-7@gated-at.bofh.it> <6pJWg-34g-5@gated-at.bofh.it> 
 <6pKfL-3sx-29@gated-at.bofh.it> <6pKpl-3Sx-23@gated-at.bofh.it> 
 <6pLll-5iq-15@gated-at.bofh.it>  <E1FsqGX-0001eu-AT@be1.lrz>
 <1150887236.15275.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Alan Cox wrote:
> Ar Mer, 2006-06-21 am 02:07 +0200, ysgrifennodd Bodo Eggert:

> > This does not work, since O_EXCL does not work:
> > http://lkml.org/lkml/2006/2/5/137
> 
> It works fine. Its an advisory exclusive locking scheme which is
> precisely what is needed and precisely how some vendors implement their
> solution.

This will be as effective as "/var/lock/please-don't-touch-the-burner",
and the lock is more portable ...

> There are good reasons for not having absolute locks, one of which is
> that you might want to force a reset or a hot unplug of an interface
> knowing you'll lose the CD its burning (eg because your flight is about
> to leave)

Killing cdrecord should take care of that lock.
