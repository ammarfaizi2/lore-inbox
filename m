Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbULaOR0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbULaOR0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 09:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbULaOR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 09:17:26 -0500
Received: from mail.convergence.de ([212.227.36.84]:31109 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262056AbULaORX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 09:17:23 -0500
Date: Fri, 31 Dec 2004 15:16:48 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bernhard Rosenkraenzer <bero@arklinux.org>,
       Gerd Knorr <kraxel@bytesex.org>
Subject: Re: Current saa7134 driver breaks KNC One Tv-Station DVR (card=24)
Message-ID: <20041231141648.GA16046@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bernhard Rosenkraenzer <bero@arklinux.org>,
	Gerd Knorr <kraxel@bytesex.org>
References: <20041231020814.GA15220@linuxtv.org> <1104481787.2791.1.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1104481787.2791.1.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 31, 2004 at 07:29:47PM +1100, Rusty Russell wrote:
> On Fri, 2004-12-31 at 03:08 +0100, Johannes Stezenbach wrote:
> > I've reported this before:
> > http://lkml.org/lkml/2004/11/17/275
> > 
> > The patch that Rusty posted doesn't seem to have it made into
> > module-init-tools-3.1. Bummer :-(
> 
> Because it was a dumb idea, as your reply showed.  You can't load any
> dependent modules because this module is not initialized yet (what if
> you loaded a module that depended on you, then failed your
> initialization?).  Gerd has the real fix, IIRC.

Yeah, but IMHO it would be better if modprobe would bail out
with an error instead of just hanging. For me hotplug
loads the drivers at boot time and it's a bad good thing if
the whole boot process hangs.

Johannes
