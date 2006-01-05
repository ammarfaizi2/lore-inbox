Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752105AbWAEIHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbWAEIHt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 03:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbWAEIHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 03:07:49 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:1417 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752105AbWAEIHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 03:07:48 -0500
Date: Thu, 5 Jan 2006 09:07:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bernd Eckenfels <be-news06@lina.inka.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops pauser. / boot_delayer
In-Reply-To: <E1EuPZg-0008Kw-00@calista.inka.de>
Message-ID: <Pine.LNX.4.61.0601050905250.10161@yvahk01.tjqt.qr>
References: <E1EuPZg-0008Kw-00@calista.inka.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> This one delays each printk() during boot by a variable time
>> (from kernel command line), while system_state == SYSTEM_BOOTING.
>
>This sounds a bit like a aprils fool joke, what it is meant to do? You can
>read the messages in the bootlog and use the scrollback keys, no?
>
If the end result is a PANIC, then no, then scrollback keys do not work. 
Also note that the kernel generates a lot of noise^W text - if now the 
start scripts from $YOUR_FAVORITE_DISTRO also fill up, I can barely reach 
the top of the kernel when it says
  Linux version 2.6.15 (jengelh@gwdg-wb04.gwdg.de) (gcc version 4.0.2 
  20050901 (prerelease) (SUSE Linux)) #1 Tue Jan 3 09:21:27 CET 2006

Plus, if you happen to oops away, panic away or just get a "VFS root
unmountable" during kernel _boot_, you cannot use scrollback either.

So to say, scrollback starts working (for me) when INIT is spawned.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
