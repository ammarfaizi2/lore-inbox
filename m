Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264973AbUHMMM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264973AbUHMMM6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265022AbUHMMM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:12:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48133 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264973AbUHMMMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:12:44 -0400
Date: Fri, 13 Aug 2004 13:12:36 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] let W1 select NET
Message-ID: <20040813131236.B5416@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	linux-kernel@vger.kernel.org
References: <20040813101717.GS13377@fs.tum.de> <Pine.LNX.4.58.0408131231480.20635@scrub.home> <1092394019.12729.441.camel@uganda> <Pine.LNX.4.58.0408131253000.20634@scrub.home> <20040813110137.GY13377@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040813110137.GY13377@fs.tum.de>; from bunk@fs.tum.de on Fri, Aug 13, 2004 at 01:01:37PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2004 at 01:01:37PM +0200, Adrian Bunk wrote:
> On Fri, Aug 13, 2004 at 12:54:25PM +0200, Roman Zippel wrote:
> > Hi,
> > 
> > On Fri, 13 Aug 2004, Evgeniy Polyakov wrote:
> > 
> > > On Fri, 2004-08-13 at 14:32, Roman Zippel wrote:
> > > > Hi,
> > > > 
> > > > On Fri, 13 Aug 2004, Adrian Bunk wrote:
> > > > 
> > > > >  config W1
> > > > >  	tristate "Dallas's 1-wire support"
> > > > > +	select NET
> > > > 
> > > > What's wrong with a simple dependency?
> > > 
> > > W1 requires NET, and thus depends on it.
> > > If you _do_ want W1 then you _do_ need network and then NET must be
> > > selected.
> > 
> > A simple "depends on NET" does this as well, I see no reason to abuse 
> > select.
> 
> In the case of NET the discussion is mostly hypothetically since nearly 
> everyone has enabled NET.

In which case, can we remove the user-visibility of CONFIG_NET and
instead make all the protocols automatically select it.

I find the over-use of "select" distasteful, and produces a counter-
intuitive configuration system.  I'll carry on complaining each time
I see a patch on LKML which introduces yet another over-use of this
feature without properly considering the consequences of doing so.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
