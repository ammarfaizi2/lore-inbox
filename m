Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263067AbSITRIN>; Fri, 20 Sep 2002 13:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263080AbSITRIM>; Fri, 20 Sep 2002 13:08:12 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:14071 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S263067AbSITRIK>;
	Fri, 20 Sep 2002 13:08:10 -0400
Date: Fri, 20 Sep 2002 10:13:15 -0700
To: thunder@lightweight.ods.org, linux-kernel@vger.kernel.org
Subject: Re: FW: 2.5.34: IR __FUNCTION__ breakage
Message-ID: <20020920171314.GD8260@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <MNEMKBGMDIMHCBHPHLGPMEEDDDAA.dag@brattli.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MNEMKBGMDIMHCBHPHLGPMEEDDDAA.dag@brattli.net>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 13, 2002 at 08:25:50AM +0200, Dag Brattli wrote:
> -----Original Message-----
> From: Thunder from the hill [mailto:thunder@lightweight.ods.org]
> Sent: 12. september 2002 22:17
> To: Bob_Tracy
> Cc: dag@brattli.net; linux-kernel@vger.kernel.org
> Subject: Re: 2.5.34: IR __FUNCTION__ breakage
> 
> 
> Hi,
> 
> On Thu, 12 Sep 2002, Bob_Tracy wrote:
> > define DERROR(dbg, args...) \
> > 	{if(DEBUG_##dbg){\
> > 		printk(KERN_INFO "irnet: %s(): ", __FUNCTION__);\
> > 		printk(KERN_INFO args);}}
> > 
> > which strikes me as not quite what the author intended, although it
> > should work.
> 
> Why not
> 
> #define DERROR(dbg, fmt, args...) \
> 	do { if (DEBUG_##dbg) \
> 		printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION, args); \
> 	} while(0)
> 
> ?
> 
> 			Thunder

	Try it, it won't work when there is zero args.

	Jean
