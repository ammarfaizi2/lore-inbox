Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261357AbTCJQBv>; Mon, 10 Mar 2003 11:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261358AbTCJQBv>; Mon, 10 Mar 2003 11:01:51 -0500
Received: from air-2.osdl.org ([65.172.181.6]:11648 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261357AbTCJQBu>;
	Mon, 10 Mar 2003 11:01:50 -0500
Date: Mon, 10 Mar 2003 08:10:24 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] move CONFIG_SWAP around
Message-Id: <20030310081024.0a2e6afe.rddunlap@osdl.org>
In-Reply-To: <20030310135014.GD31298@ip68-0-152-218.tc.ph.cox.net>
References: <200303090406.h2946Tj06060@hera.kernel.org>
	<Pine.GSO.4.21.0303101133380.8949-100000@vervain.sonytel.be>
	<20030310135014.GD31298@ip68-0-152-218.tc.ph.cox.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Mar 2003 06:50:14 -0700 Tom Rini <trini@kernel.crashing.org> wrote:

| On Mon, Mar 10, 2003 at 11:36:29AM +0100, Geert Uytterhoeven wrote:
| > On Sun, 9 Mar 2003, Linux Kernel Mailing List wrote:
| > > ChangeSet 1.1148, 2003/03/08 19:25:21-08:00, akpm@digeo.com
| > > 
| > > 	[PATCH] move CONFIG_SWAP around
| > > 	
| > > 	Patch from Tom Rini <trini@kernel.crashing.org>
| > > 	
| > > 	Take CONFIG_SWAP out of the top-level menu into the general setup menu.  Make
| > > 	it dependent on CONFIG_MMU and common to all architectures.
| > > 
| > > 
| > > --- a/init/Kconfig	Sat Mar  8 20:06:31 2003
| > > +++ b/init/Kconfig	Sat Mar  8 20:06:31 2003
| > > @@ -37,6 +37,16 @@
| > >  
| > >  menu "General setup"
| > >  
| > > +config SWAP
| > > +	bool "Support for paging of anonymous memory"
| > > +	depends on MMU
| > > +	default y
| > > +	help
| > > +	  This option allows you to choose whether you want to have support
| > > +	  for socalled swap devices or swap files in your kernel that are
| > > +	  used to provide more virtual memory than the actual RAM present
| > > +	  in your computer.  If unusre say Y.
| >                                 ^^^^^^
| > unsure
| 
| D'oh... Not mine 'tho, I think it can from Randy :)

Nope, I just checked and my patch contained a fix for that.  8:)
As did Tomas Szepe's patch.

--
~Randy
