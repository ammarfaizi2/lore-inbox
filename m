Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261362AbTCJQtT>; Mon, 10 Mar 2003 11:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbTCJQtT>; Mon, 10 Mar 2003 11:49:19 -0500
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:20641 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S261362AbTCJQtS>; Mon, 10 Mar 2003 11:49:18 -0500
Date: Mon, 10 Mar 2003 09:59:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move CONFIG_SWAP around
Message-ID: <20030310165956.GA10044@ip68-0-152-218.tc.ph.cox.net>
References: <200303090406.h2946Tj06060@hera.kernel.org> <Pine.GSO.4.21.0303101133380.8949-100000@vervain.sonytel.be> <20030310135014.GD31298@ip68-0-152-218.tc.ph.cox.net> <20030310081024.0a2e6afe.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310081024.0a2e6afe.rddunlap@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 10, 2003 at 08:10:24AM -0800, Randy.Dunlap wrote:
> On Mon, 10 Mar 2003 06:50:14 -0700 Tom Rini <trini@kernel.crashing.org> wrote:
> 
> | On Mon, Mar 10, 2003 at 11:36:29AM +0100, Geert Uytterhoeven wrote:
> | > On Sun, 9 Mar 2003, Linux Kernel Mailing List wrote:
> | > > ChangeSet 1.1148, 2003/03/08 19:25:21-08:00, akpm@digeo.com
> | > > 
> | > > 	[PATCH] move CONFIG_SWAP around
> | > > 	
> | > > 	Patch from Tom Rini <trini@kernel.crashing.org>
> | > > 	
> | > > 	Take CONFIG_SWAP out of the top-level menu into the general setup menu.  Make
> | > > 	it dependent on CONFIG_MMU and common to all architectures.
> | > > 
> | > > 
> | > > --- a/init/Kconfig	Sat Mar  8 20:06:31 2003
> | > > +++ b/init/Kconfig	Sat Mar  8 20:06:31 2003
> | > > @@ -37,6 +37,16 @@
> | > >  
> | > >  menu "General setup"
> | > >  
> | > > +config SWAP
> | > > +	bool "Support for paging of anonymous memory"
> | > > +	depends on MMU
> | > > +	default y
> | > > +	help
> | > > +	  This option allows you to choose whether you want to have support
> | > > +	  for socalled swap devices or swap files in your kernel that are
> | > > +	  used to provide more virtual memory than the actual RAM present
> | > > +	  in your computer.  If unusre say Y.
> | >                                 ^^^^^^
> | > unsure
> | 
> | D'oh... Not mine 'tho, I think it can from Randy :)
> 
> Nope, I just checked and my patch contained a fix for that.  8:)
> As did Tomas Szepe's patch.

Yeah, I found it was upstream just after I sent that.  I'm supprised the
spell check people haven't found that one yet.

-- 
Tom Rini
http://gate.crashing.org/~trini/
