Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317387AbSILVFX>; Thu, 12 Sep 2002 17:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSILVFX>; Thu, 12 Sep 2002 17:05:23 -0400
Received: from gherkin.frus.com ([192.158.254.49]:11916 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S318778AbSILVFO>;
	Thu, 12 Sep 2002 17:05:14 -0400
Message-Id: <m17pbDY-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: 2.5.34: IR __FUNCTION__ breakage
In-Reply-To: <Pine.LNX.4.44.0209121414570.10048-100000@hawkeye.luckynet.adm>
 "from Thunder from the hill at Sep 12, 2002 02:16:49 pm"
To: Thunder from the hill <thunder@lightweight.ods.org>
Date: Thu, 12 Sep 2002 16:09:40 -0500 (CDT)
CC: dag@brattli.net, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thunder from the hill wrote:
> (good suggestion)

so the revised definition expands from two+ to three+ arguments and
becomes

#define DERROR(dbg, fmt, args...) \
    {if(DEBUG_##dbg) \
    	printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION__, args);}

in the style of the original code.  There aren't all that many source
files that depend on irnet.h, so this shouldn't be too painful.

TO DO: under linux/net/irda, there's a *lot* of cli(), restore_flags(),
save_flags() cleanup work, which I'll happily leave to Jean and/or
Dag :-).

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
