Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTGCO2s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 10:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263705AbTGCO2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 10:28:48 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:39175 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S263633AbTGCO1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 10:27:47 -0400
Date: Thu, 3 Jul 2003 16:41:53 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 868] New: Files missing?
Message-ID: <20030703144153.GA11767@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
References: <45000000.1057241473@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45000000.1057241473@[10.10.2.4]>
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin J. Bligh <mbligh@aracnet.com>
Date: Thu, Jul 03, 2003 at 07:11:13AM -0700
> http://bugme.osdl.org/show_bug.cgi?id=868
> 
>            Summary: Files missing?
>     Kernel Version: 2.5.73,2.5.74
>             Status: NEW
>           Severity: normal
>              Owner: bugme-janitors@lists.osdl.org
>          Submitter: midian@ihme.org
> 
> 
> Distribution: Debian
> Hardware Environment: AMD Athlon 2000+, 512 SDRAM
> Software Environment:
> Problem Description: Missing files in kernel?
> 
> Steps to reproduce: wget http://www.kernel.org/pub/linux/kernel/v2.5/linux-2.5.
> 74.tar.bz2 && tar xjvf linux-2.5.74.tar.bz2 && cp linux-2.4.22-pre2/.config 
> linux-2.5.74/. && cd linux-2.5.74/ && make oldconfig && make menuconfig && make 
> all (And the same with 2.5.73, I have not tested the earlier versions.)
> 
> Error message: CC [M]  drivers/video/pm2fb.o
> drivers/video/pm2fb.c:44:25: video/fbcon.h: No such file or directory

This driver hasn't been ported to the new framebuffer api.

Perhaps including a video/fbcon.h file which contains

#error "You are trying to compile a framebuffer which hasn't been ported
to the new api yet - compilation will fail."

would be a good idea?

Jurriaan
-- 
To err is human, to forgive, beyond the scope of the Operating System.
Debian (Unstable) GNU/Linux 2.5.74 4112 bogomips load av: 0.04 0.05 0.01
