Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSILUNH>; Thu, 12 Sep 2002 16:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSILUNH>; Thu, 12 Sep 2002 16:13:07 -0400
Received: from pD9E23F87.dip.t-dialin.net ([217.226.63.135]:58598 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317182AbSILUNG>; Thu, 12 Sep 2002 16:13:06 -0400
Date: Thu, 12 Sep 2002 14:16:49 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Bob_Tracy <rct@gherkin.frus.com>
cc: dag@brattli.net, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.34: IR __FUNCTION__ breakage
In-Reply-To: <m17pa2L-0005khC@gherkin.frus.com>
Message-ID: <Pine.LNX.4.44.0209121414570.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 12 Sep 2002, Bob_Tracy wrote:
> define DERROR(dbg, args...) \
> 	{if(DEBUG_##dbg){\
> 		printk(KERN_INFO "irnet: %s(): ", __FUNCTION__);\
> 		printk(KERN_INFO args);}}
> 
> which strikes me as not quite what the author intended, although it
> should work.

Why not

#define DERROR(dbg, fmt, args...) \
	do { if (DEBUG_##dbg) \
		printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION, args); \
	} while(0)

?

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

