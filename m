Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263290AbTKJX5A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 18:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263292AbTKJX5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 18:57:00 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:41988 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263290AbTKJX45
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 18:56:57 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ?
Date: 10 Nov 2003 23:46:24 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bop80f$7s7$1@gatekeeper.tmr.com>
References: <bop47i$7eg$1@gatekeeper.tmr.com> <6.0.0.22.2.20031111101721.01bde418@caffeine.cc.com.au>
X-Trace: gatekeeper.tmr.com 1068507984 8071 192.168.12.62 (10 Nov 2003 23:46:24 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <6.0.0.22.2.20031111101721.01bde418@caffeine.cc.com.au>,
Peter Lieverdink  <linux@cafuego.net> wrote:
| 
| At 09:41 11/11/2003, you wrote:
| >In article <20031109131018.GA18342@deneb.enyo.de>,
| >Florian Weimer  <fw@deneb.enyo.de> wrote:
| >| Soeren Sonnenburg wrote:
| >|
| >| > losetup -e blowfish /dev/loop0 /file
| >| > Password:
| >| > mkfs -t ext3 /dev/loop0
| >| > mount /dev/loop0 /mnt
| >| > <error unknown fs type>
| >| > <from here something was seriously broken... could not reboot anymore>
| >|
| >| I'm seeing something similar, but in my case, mke2fs already crashes.
| >|
| >| > system is:
| >| > Linux no 2.6.0-test7 #8 Sun Oct 26 17:00:49 CET 2003 ppc GNU/Linux
| >|
| >| Mine ist -test9 on x86.
| >|
| >| Have you found a solution in the meantime?
| >
| >I have been using aes and not seeing this. I suppose it's unlikely that
| >there could be an error in the kernel crypto, but I think I'll wait and
| >try blowfish on a non-critical machine.
| 
| My solution has been to not use cryptofs, it crashes with whatever 
| algorithm I choose :-(
| 
| I agree that something is very broken, though. Mind you, I can only 
| replicate this problem on one of my machines - the other one I've tried it 
| on seems to work fine. Odder still, when I compile a kernel on the machine 
| which is fine and ruin said kernel on the machine which is not fine, I 
| don't experience the crash.

Compiler version problem? In any case it sounds as if you have a
solution for the moment.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
