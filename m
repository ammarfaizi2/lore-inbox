Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262146AbTHTTfj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 15:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbTHTTfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 15:35:39 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:7429 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S262146AbTHTTff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 15:35:35 -0400
Date: Wed, 20 Aug 2003 21:35:18 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 test3-bk7 & -mm3 : HPT374 - cable missdetection, lock-ups
Message-ID: <20030820193518.GA1547@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <1061384019.3f436f531a333@secure.st-peter.stw.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061384019.3f436f531a333@secure.st-peter.stw.uni-erlangen.de>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
Date: Wed, Aug 20, 2003 at 02:53:39PM +0200
> Hi
> 
> first test run of 2.6 on Epox 8k9a3+ VIA KT400 VT8235, 
> HPT374 and 4 IBM Deskstar GXP120 80Gb on each chanel as master
> Mandrake-cooker gcc-3.3.1
> 
> the 3rd and the 4th chanel of the HPT374 are saying that the used cable
> is 40 wires, so it forces the drives in UDMA33 which i think causes the lock-
> ups several seconds after booting in runlevel 1
> 
As far as I know, I have no problems with my 3rd channel on my Epox
8K9A3+ motherboard. I've got a WD 80 Gb disk (8 Mb cache model) on it.

However, I've noticed something else.

As soon as I type 

cat /proc/ide/hpt366

I get hit by the dreaded 'status=0x58 .... hdi interrupt lost' thing.
It tries to reset ide4, but keeps telling 'interrupt lost' and finally I
have to use the reset button. If I never cat /proc/ide/hpt366 I can run
the system for a week at a time, where hdi is part of a raid-0 partition
that contains both /home and my newsspool - so it's used frequently.

Kind regards,
Jurriaan
-- 
Carson heaved a sigh. "Easley tried to kill you. You retaliate by calling
yourself Jim Harrison. It seems a subtle revenge. Perhaps I'm stupid..."
	Jack Vance - The Deadly Isles
Debian (Unstable) GNU/Linux 2.6.0-test3-mm3 4259 bogomips 1.04 0.41
