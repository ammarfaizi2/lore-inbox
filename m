Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031308AbWI1BBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031308AbWI1BBg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 21:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031315AbWI1BBg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 21:01:36 -0400
Received: from mail.gmx.de ([213.165.64.20]:32460 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1031308AbWI1BBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 21:01:35 -0400
X-Authenticated: #5039886
Date: Thu, 28 Sep 2006 03:01:33 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Andrew Morton <akpm@osdl.org>, Martin Filip <bugtraq@smoula.net>,
       linux-kernel@vger.kernel.org, Ayaz Abdulla <aabdulla@nvidia.com>
Subject: Re: forcedeth - WOL [SOLVED]
Message-ID: <20060928010133.GB3521@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Andrew Morton <akpm@osdl.org>, Martin Filip <bugtraq@smoula.net>,
	linux-kernel@vger.kernel.org, Ayaz Abdulla <aabdulla@nvidia.com>
References: <1159379441.9024.7.camel@archon.smoula-in.net> <20060927183857.GA2963@atjola.homenet> <1159389486.8902.4.camel@archon.smoula-in.net> <20060927165704.613bf0aa.akpm@osdl.org> <20060928000447.GB2963@atjola.homenet> <20060928004053.GA3521@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060928004053.GA3521@atjola.homenet>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006.09.28 02:40:53 +0200, Björn Steinbrink wrote:
> On 2006.09.28 02:04:48 +0200, Björn Steinbrink wrote:
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

As I like replying to myself, I of course intentionally forgot to answer
this question... *sigh*

I used etherwake this time, but tried with a self-made tool (which works
with my Broadcom NIC) when I discovered the bug report.

etherwake 01:23:45:67:89:ab -- works when I shutdown during POST
etherwake ab:89:67:45:23:01 -- works when WOL was enabled with ethtool

> > > Do we know if this reversal *always* happens with this driver, or only
> > > sometimes?

I only tried 2.6.18 twice this time, but when I wrote my own tool to do
it, I had probably 20-30 power on -> ethtool -> poweroff cycles before I
decided to look into Bugzilla. As it looked like being fixed already and
I did use the nForce NIC for testing only, I didn't spend any further
time on it back then.

Regards,
Björn
