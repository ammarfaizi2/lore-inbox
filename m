Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTHTUrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 16:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbTHTUrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 16:47:10 -0400
Received: from voyager.st-peter.stw.uni-erlangen.de ([131.188.24.132]:13224
	"EHLO voyager.st-peter.stw.uni-erlangen.de") by vger.kernel.org
	with ESMTP id S262193AbTHTUrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 16:47:05 -0400
X-Mailbox-Line: From galia@st-peter.stw.uni-erlangen.de  Wed Aug 20 22:47:03 2003
Message-ID: <1061412422.3f43de468d5aa@secure.st-peter.stw.uni-erlangen.de>
Date: Wed, 20 Aug 2003 22:47:02 +0200
From: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
To: thunder7@xs4all.nl
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 test3-bk7 & -mm3 : HPT374 - cable missdetection, lock-ups
References: <1061384019.3f436f531a333@secure.st-peter.stw.uni-erlangen.de> <20030820193518.GA1547@middle.of.nowhere>
In-Reply-To: <20030820193518.GA1547@middle.of.nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jurriaan <thunder7@xs4all.nl>:

> From: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
> Date: Wed, Aug 20, 2003 at 02:53:39PM +0200
> > Hi
> > 
> > first test run of 2.6 on Epox 8k9a3+ VIA KT400 VT8235, 
> > HPT374 and 4 IBM Deskstar GXP120 80Gb on each chanel as master
> > Mandrake-cooker gcc-3.3.1
> > 
> > the 3rd and the 4th chanel of the HPT374 are saying that the used cable
> > is 40 wires, so it forces the drives in UDMA33 which i think causes the
> lock-
> > ups several seconds after booting in runlevel 1
> > 
> As far as I know, I have no problems with my 3rd channel on my Epox
> 8K9A3+ motherboard. I've got a WD 80 Gb disk (8 Mb cache model) on it.

a WD 80Gb, as in a single hard drive on the HPT374 ?

my first 2 chanels seems to be OK (couldn't test them good)
but they survive hdparm -d1 -u1 -c1 -X69, where as the 3rd & 4th chanel
reported UDMA4/5/6 not functional (or smth similar) and the system went down


> However, I've noticed something else.
> 
> As soon as I type 
> 
> cat /proc/ide/hpt366

there might be smth similar here, but i get the lockups even if i don't play 
with /proc/ide hdparm, and 1st, 2nd chanel are running at UDMA100 3rd, 4th at 
UDMA33
 
> I get hit by the dreaded 'status=0x58 .... hdi interrupt lost' thing.
> It tries to reset ide4, but keeps telling 'interrupt lost' and finally I
> have to use the reset button. If I never cat /proc/ide/hpt366 I can run
> the system for a week at a time, where hdi is part of a raid-0 partition
> that contains both /home and my newsspool - so it's used frequently.
> 
> Kind regards,
> Jurriaan

best,

svetljo

