Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031319AbWI1BDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031319AbWI1BDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:03:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031316AbWI1BDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:03:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59881 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031319AbWI1BDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:03:34 -0400
Date: Wed, 27 Sep 2006 18:03:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Cc: Martin Filip <bugtraq@smoula.net>, linux-kernel@vger.kernel.org,
       Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: forcedeth - WOL [SOLVED]
Message-Id: <20060927180317.478cd8f6.akpm@osdl.org>
In-Reply-To: <20060928004053.GA3521@atjola.homenet>
References: <1159379441.9024.7.camel@archon.smoula-in.net>
	<20060927183857.GA2963@atjola.homenet>
	<1159389486.8902.4.camel@archon.smoula-in.net>
	<20060927165704.613bf0aa.akpm@osdl.org>
	<20060928000447.GB2963@atjola.homenet>
	<20060928004053.GA3521@atjola.homenet>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 02:40:53 +0200
Bj__rn Steinbrink <B.Steinbrink@gmx.de> wrote:

> On 2006.09.28 02:04:48 +0200, Bj__rn Steinbrink wrote:
> > 
> > Hi Andrew,
> > 
> > 
> > On 2006.09.27 16:57:04 -0700, Andrew Morton wrote:
> > > On Wed, 27 Sep 2006 22:38:06 +0200
> > > Martin Filip <bugtraq@smoula.net> wrote:
> > > 
> > > > Hi,
> > > > 
> > > > Bj__rn Steinbrink p____e v St 27. 09. 2006 v 20:38 +0200:
> > > > 
> > > > > Did you check that WOL was enabled? I need to re-activate it after each
> > > > > boot (I guess that's normal, not sure though).
> > > > > The output of "ethtool eth0" should show:
> > > > > 
> > > > >         Supports Wake-on: g
> > > > >         Wake-on: g
> > > > > 
> > > > Yes, of course :)
> > > > 
> > > > > Also, I remember a bugzilla entry in which it was said that the MAC was
> > > > > somehow reversed by the driver. I that is still the case (I can't find
> > > > > the bugzilla entry right now), you might just reverse the MAC address in
> > > > > your WOL packet to workaround the bug.
> > > > 
> > > > Hey! this is really crazy :) but it works! To bo honest - I really do
> > > > not know what crazy bug could cause problems like this. I thought it's
> > > > NIC thing to manage all the work about WOL. I thought OS only sets NIC
> > > > into "WOL mode".
> > > > 
> > > > But seeing this - one packet for windows and one magic packet for linux
> > > > driver - I really do not get it.
> > > > 
> > > 
> > > Are you saying that byte-reversing the MAC address make WOL work correctly?
> > > 
> > > What tool do you use to send the packet, and how is it being invoked?
> > > 
> > > Do we know if this reversal *always* happens with this driver, or only
> > > sometimes?
> > > 
> > > Thanks.
> > 
> > searching bugzilla was more succesful this time (somehow bugzillas hate
> > me, so I need a bunch of tries every time), the bug I meant was #6604.
> > 
> > The bugreport says that it should work with 0.57 though (which is in
> > 2.6.18 AFAICT), I'll go and see if it works for me...
> 
> ... 5 reboots later ...
> 
> It still breaks with 2.6.18.
> 
> Not touching WOL from Linux at all, rebooting and turning the box off
> during POST, WOL works using the real MAC address.
> 
> Booting 2.16.17.x or 2.6.18, turning on WOL and finally shutting down
> the box, I need to send the WOL packet with the MAC address reversed.
> 

Could I re-ask these questions?


Are you saying that byte-reversing the MAC address make WOL work correctly?

What tool do you use to send the packet, and how is it being invoked?

Do we know if this reversal *always* happens with this driver, or only
sometimes?

