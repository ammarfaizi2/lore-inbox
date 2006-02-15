Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWBOTrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWBOTrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 14:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWBOTrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 14:47:53 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32718
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1750992AbWBOTrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 14:47:52 -0500
From: Rob Landley <rob@landley.net>
To: Doug McNaught <doug@mcnaught.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Date: Wed, 15 Feb 2006 14:47:39 -0500
User-Agent: KMail/1.8.3
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <200602151409.41523.rob@landley.net> <87k6bwl9ez.fsf@asmodeus.mcnaught.org>
In-Reply-To: <87k6bwl9ez.fsf@asmodeus.mcnaught.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602151447.40617.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 February 2006 2:16 pm, Doug McNaught wrote:
> Rob Landley <rob@landley.net> writes:
> > On Wednesday 15 February 2006 1:31 pm, Lennart Sorensen wrote:
> >> once.
> >
> > Yup.  Apparently with SAS, the controllers are far more likely to fail
> > than the drives.
>
> I think the actual idea (or one of them) is to have two machines
> connected to each drive, in a hot-standby configuration.  This has
> been done for a long time with parallel SCSI, where both machines have
> controllers on the bus.

Ah.  I'm used to projects doing that through ethernet instead, in various 
hand-rolled implementations.  A generic solution for staying in sync through 
the network would be nice.

A potentially interesting project might be hooking into the journaling stuff 
to update a network block device as data gets flushed out of the journal.  
It'd need some kind of heartbeat mechanism (if the network block device 
doesn't confirm receipt of the data within X seconds, don't hold up flushing 
the journal to the filesystem and moving on with life).  And some mechanism 
to get back in sync after getting out of sync, which could be done a number 
of ways.

I wonder if there's already something like this?  (Probably...)

> -Doug

Rob
-- 
Never bet against the cheap plastic solution.
