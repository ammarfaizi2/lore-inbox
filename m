Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319691AbSIMQKD>; Fri, 13 Sep 2002 12:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319696AbSIMQKD>; Fri, 13 Sep 2002 12:10:03 -0400
Received: from pD952AD04.dip.t-dialin.net ([217.82.173.4]:62957 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319691AbSIMQKB>; Fri, 13 Sep 2002 12:10:01 -0400
Date: Fri, 13 Sep 2002 10:14:01 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Andreas Steinmetz <ast@domdv.de>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Bob_Tracy <rct@gherkin.frus.com>, <dag@brattli.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.34: IR __FUNCTION__ breakage
In-Reply-To: <3D820BC9.5080207@domdv.de>
Message-ID: <Pine.LNX.4.44.0209131013080.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Sep 2002, Andreas Steinmetz wrote:
> At least for gcc 3.2 this would be better:
> 
> #define DERROR(dbg, fmt, args...) \
>      do { if (DEBUG_##dbg) \
>          printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION__, ##args); \
>      } while(0)
> 
> Unfortunately this doesn't work with gcc 2.95.3.

Yepp. As usual, I've forgot the half of it. The second underscores of 
__FUNCTION__ were victims, just like the double hash before args.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

