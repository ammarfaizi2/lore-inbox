Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265327AbUAACWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 21:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbUAACWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 21:22:12 -0500
Received: from [24.35.117.106] ([24.35.117.106]:29312 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265327AbUAACWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 21:22:09 -0500
Date: Wed, 31 Dec 2003 21:21:56 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Jeff Garzik <jgarzik@pobox.com>
cc: Lennert Buytenhek <buytenh@gnu.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-mm2] e100 driver hangs after period of moderate receive
 load
In-Reply-To: <3FF2C266.8010104@pobox.com>
Message-ID: <Pine.LNX.4.58.0312312115120.3069@localhost.localdomain>
References: <20031231110209.GA9858@gnu.org> <3FF2BCDE.5010302@pobox.com>
 <20031231122155.GA13323@gnu.org> <3FF2C266.8010104@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 31 Dec 2003, Jeff Garzik wrote:

> Lennert Buytenhek wrote:
> > On Wed, Dec 31, 2003 at 07:11:10AM -0500, Jeff Garzik wrote:
> > 
> > 
> >>>After banging on an e100 card for about ten minutes with a ~60kpps stream,
> >>>the interface stops receiving packets.  Interrupts come in once every few
> >>>seconds (from /proc/interrupts), but no packets are received anymore at 
> >>>all.
> >>>Lots of slab corruption messages in the syslog that were generated during
> >>>that packet stream (see other email I sent.)  Stopping the packet stream
> >>>still leaves the interface unusable.  'ifconfig eth1 down ; ifconfig eth1 
> >>>up'
> >>>seems to fix things.
> >>
> >>Is NAPI enabled for this driver?  The interrupt behavior seems normal 
> >>for NAPI, but certainly the rest of the behavior does not...
> > 
> > 
> > Yes, NAPI was indeed enabled.
> > 
> > I 'went back' to 2.6.1-rc1 and that seems fine now.  Any patches you want
> > me to try on top of 2.6.0-mm2?
> 
> 
> Well, the two are vastly different, since -mm2 includes a complete 
> rewrite of e100.
> 
> Does disabling NAPI in -mm2 change anything?

I have one of these beasts so I decided to test it after seeing this 
message.  2.6.0-mm2 NAPI enabled and I am not seeing any of the symptoms 
described here.  My test consists of downloading an iso from RedHat's ftp 
site.  I'm not sure that is generating the kind of traffic you are talking 
about, but I'm open to suggestions on what test to run trying to duplicate 
what is being reported.
