Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWCMThR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWCMThR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 14:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbWCMThQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 14:37:16 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:21266 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932368AbWCMThP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 14:37:15 -0500
Date: Mon, 13 Mar 2006 20:36:43 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Adrian Bunk <bunk@stusta.de>, rjwalsh@pathscale.com, rolandd@cisco.com,
       gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 18 of 20] ipath - kbuild infrastructure
Message-ID: <20060313193643.GB32349@mars.ravnborg.org>
References: <patchbomb.1141950930@eng-12.pathscale.com> <867a396dd518ac63ab41.1141950948@eng-12.pathscale.com> <20060313181025.GA13973@stusta.de> <1142277868.9032.14.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142277868.9032.14.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2006 at 11:24:28AM -0800, Bryan O'Sullivan wrote:
> On Mon, 2006-03-13 at 19:10 +0100, Adrian Bunk wrote:
> 
> > I'm still a bit surprised, since in the rest of the kernel we are even 
> > going from -O2 to -Os for getting better performance.
> > 
> > Robert said he wanted to post some numbers showing that -O3 is 
> > measurably better for you [1], but I haven't seen them.
> 
> I just ran some numbers.  At large packet sizes, it doesn't matter what
> options we use, because we spend all of our time in __iowrite_copy32,
> which uses the string copy instructions.
> 
> For small packets, my quick tests indicate that -Os gives about 5%
> *better* performance than -O3 (using gcc 4 on FC4).  This is in line
> with what people have been finding in the kernel in general recently.
> 
> So if I change that CFLAGS line from -O3 to -Os, are we in OK
> shape?  :-)
Use the kernel settings. We cannot have this modified by each and every
driver.

	Sam
