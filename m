Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbULZESv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbULZESv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 23:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbULZESv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 23:18:51 -0500
Received: from main.gmane.org ([80.91.229.2]:33440 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261612AbULZESr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 23:18:47 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Ho ho ho - Linux v2.6.10
Date: Sun, 26 Dec 2004 09:19:23 +0500
Message-ID: <cqle2s$hrm$1@sea.gmane.org>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 49-214.dial.utk.ru
User-Agent: KNode/0.7.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Ok, with a lot of people taking an xmas break, here's something to play
> with over the holidays (not to mention an excuse for me to get into the
> Gl?gg for real ;)

Here it boots and works, but I can't say that I have done any serious
testing. The following message appears in the kernel log:

Dec 25 11:38:09 lfs parport_pc: Ignoring new-style parameters in presence of
obsolete ones
Dec 25 11:38:09 lfs parport_pc: VIA 686A/8231 detected
Dec 25 11:38:09 lfs parport_pc: probing current configuration
Dec 25 11:38:09 lfs parport_pc: Current parallel port base: 0x378
Dec 25 11:38:09 lfs parport0: PC-style at 0x378 (0x778), irq 7, using FIFO
[PCSPP,TRISTATE,COMPAT,ECP]
Dec 25 11:38:09 lfs parport_pc: VIA parallel port: io=0x378, irq=7

I don't understand the first line, and it wasn't there in 2.6.9. Could you
please explain what it means? I don't pass any parameters to the module. I
use module-init-tools version 3.0 although I know it is not the latest.

Relevant .config portion:

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

-- 
Alexander E. Patrakov

