Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbVHISos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbVHISos (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 14:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbVHISos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 14:44:48 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:25259 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750734AbVHISor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 14:44:47 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: my kernel sometimes did a crash, but no panic
To: klasyk99@poczta.onet.pl, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 09 Aug 2005 20:44:31 +0200
References: <4zEQ3-7Le-21@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1E2Z5U-0004ji-Nt@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: harvested.in.lkml@posting.7eggert.dyndns.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klasyk <klasyk99@poczta.onet.pl> wrote:

> my kernel sometimes did a crash, but no panic
> Keyboard hunged up :(
> Network were working and I can log in. Without the keybord - it
> generally worked.
> 
> In logs:
> for example:
> 
> Aug  6 15:30:02 o kernel: Unable to handle kernel NULL pointer
> dereference at virtual address 00
> 000000
> Aug  6 15:30:02 o kernel:  printing eip:
> Aug  6 15:30:02 o kernel: c026b0d9
> Aug  6 15:30:02 o kernel: *pde = 3588d001
> Aug  6 15:30:02 o kernel: Oops: 0000 [#1]
> Aug  6 15:30:02 o kernel: Modules linked in: ip_nat_irc
[...]
> 4 ieee1394 loop via-agp bt878 tuner tvaudio bttv video-buf
                                              ^^^^
It's probably the same problem I had.

There is a recent patch enabling the no_overlay=1 parameter and some PCI
quirks to autotune this option. Please try that and, if your board isn't
autodetected, the lspci -vvv output and the exact name of your MB chipset.

I temporarily uploaded the patch to
http://7eggert.dyndns.org/l/scratch/v4l_bttv_no_overlay_linus.patch
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
