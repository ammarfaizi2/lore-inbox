Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262965AbUJ0V6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262965AbUJ0V6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 17:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262720AbUJ0VyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 17:54:10 -0400
Received: from mail.dif.dk ([193.138.115.101]:53428 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262958AbUJ0Vw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 17:52:26 -0400
Date: Thu, 28 Oct 2004 00:00:45 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Joel Jaeggli <joelja@darkwing.uoregon.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dual Opteron box, what's the optimal memory placement for the
 CPUs?
In-Reply-To: <Pine.LNX.4.61.0410271439000.6240@twin.uoregon.edu>
Message-ID: <Pine.LNX.4.61.0410272355300.3284@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0410272316160.3284@dragon.hygekrogen.localhost>
 <Pine.LNX.4.61.0410271439000.6240@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Joel Jaeggli wrote:

> On Wed, 27 Oct 2004, Jesper Juhl wrote:
> 
> > 
> > Quick question,
> > 
> > I've got an IBM eServer 325 here with 2 Opteron 240 CPUs. The box has 6
> > DIMM slots, 4 for the "primary" CPU and 2 for the second one. I've got the
> > following memory sticks : 4x512MB and 2x1GB
> > 
> > My plan is to plug the 4 512MB sticks into the slots for the first CPU and
> > the 2GB sticks into the two slots for the second CPU, giving them 2GB
> > each, but I could also give the first one 2x512MB and 2x1GB and the second
> > one 2x512MB giving the first CPU 3GB and the second 1GB. Does it matter at
> > all.
> 
> doesn't really matter, they just have to be installed in pairs for bank
> interleaving. node interleaving is dependant on having banks on both cpu's
> populated.
> 
Yeah, I know they have to be installed in pairs, but I would have thought 
that it would be best to have an even memory distribution so that an even 
amount of local memory was available to processes executing on either CPU. 
Even if Linux makes sure to execute processes on the CPU where most of 
their memory is local, wouldn't a non-even distribution make more 
processes prefer one CPU and thus not make the best possible use of them?

I don't really know very much about this specific detail (which is why I 
asked), and you tell me it doesn't matter, so I'll assume Linux has some 
intelligent way of dealing with this that I just don't know about - That's 
good enough for me, I'll trust you on that, just wanted to know for now 
and the future. :-)


--
Jesper Juhl

