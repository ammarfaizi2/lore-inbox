Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265708AbTATMpP>; Mon, 20 Jan 2003 07:45:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265736AbTATMpO>; Mon, 20 Jan 2003 07:45:14 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:8390 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265708AbTATMoh>;
	Mon, 20 Jan 2003 07:44:37 -0500
Date: Mon, 20 Jan 2003 12:51:00 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Wolfgang Fritz <wolfgang.fritz@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsuspend: possible with VIA Eden processor? Or alternatives?
Message-ID: <20030120125100.GA27330@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Wolfgang Fritz <wolfgang.fritz@gmx.net>,
	linux-kernel@vger.kernel.org
References: <b0c20t$rt$1@fritz38552.news.dfncis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c20t$rt$1@fritz38552.news.dfncis.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2003 at 06:14:04PM +0100, Wolfgang Fritz wrote:
 > Hi,
 > 
 > the swsuspend mini howto says that a processor with pse/pse36 feature is 
 > required for swsupend in 2.4.
 > 
 > So I am obviously out of luck with 2.4 kernels, but what about 2.5 (the 
 > mini-howto is silent here)?

>From include/asm-i386/suspend.h

static inline void
arch_prepare_suspend(void)
{
    if (!cpu_has_pse)
        panic("pse required");
}

There's really no requirement that you *need* PSE to be able to
do suspend, but it seems no-one has stepped forward to write the
necessary code to support non-PSE afaics.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
