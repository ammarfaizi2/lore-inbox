Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270316AbTGRS5P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 14:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270308AbTGRS5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 14:57:15 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:34821 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S270272AbTGRS44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 14:56:56 -0400
Date: Fri, 18 Jul 2003 12:11:43 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Sb16 kernel parameters.
Message-ID: <20030718191143.GA4583@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030717220915.GA5046@ping.be> <3F1730C9.4020300@sbcglobal.net> <s5hsmp4jh49.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hsmp4jh49.wl@alsa2.suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 11:53:26AM +0200, Takashi Iwai wrote:
> At Thu, 17 Jul 2003 18:27:05 -0500,
> Wes Janzen wrote:
> > 
> > And at the end of the sb16.c file I found:
> > 
> > #ifndef MODULE
> > 
> > /* format is: snd-sb16=enable,index,id,isapnp,
> >                        port,mpu_port,fm_port,
> >                        irq,dma8,dma16,
> >                        mic_agc,csp,
> >                        [awe_port,seq_ports]
> > 
> > Which is probably what format you'll need to use but I don't know much 
> > about drivers...;-)
> > I don't know what "id" stands for either...
> 
> enable, index and id are common options for all modules.
> the id is the identifier string for this card instance and must be
> unique.  it's used as the directory name in /proc/asound, as the tag
> in /etc/asound.state, and so on.
> you can pass the arbitray string via option, or the null string so
> that the driver chooses an approriate name.

I've not been testing 2.5 yet and perhaps some of what you
said would make more sense if i had but i for one haven't a
clue to what the string equivalent to "sb=0x220,7,1,5" would
be or where i might specify it.  It's been a couple of years
since i did the digging to figure out i needed the sb= line
and what the contents should be.

How to do this needs to go into the 2.4-2.6 migration
document/FAQ.  And it should go in in a rather explicit way
on the order of "if for SB16 you have been using
sb=0x220,7,1,5 as a boot parameter you would now need to use
XXXX=XXXXXXXXXX as ZZZZZ.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
