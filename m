Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbVKKXtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbVKKXtu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 18:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbVKKXtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 18:49:50 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:58054 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1750711AbVKKXtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 18:49:50 -0500
Date: Fri, 11 Nov 2005 15:49:48 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Claudio Scordino <cloud.of.andor@gmail.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       "Magnus Naeslund(f)" <mag@fbab.net>,
       "Hua Zhong (hzhong)" <hzhong@cisco.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org, David Wagner <daw@cs.berkeley.edu>
Subject: Re: [PATCH] getrusage sucks
In-Reply-To: <200511120043.52796.cloud.of.andor@gmail.com>
Message-ID: <Pine.LNX.4.63.0511111547310.18982@twinlark.arctic.org>
References: <75D9B5F4E50C8B4BB27622BD06C2B82BCF2FD4@xmb-sjc-235.amer.cisco.com>
 <20051111230223.GB7991@shell0.pdx.osdl.net> <1131753496.3174.55.camel@localhost.localdomain>
 <200511120043.52796.cloud.of.andor@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Nov 2005, Claudio Scordino wrote:

> >
> > In which case the only comment I have is the one about accuracy - and
> > that is true for procfs too so will only come up if someone gets the
> > urge to use perfctr timers for precision resource management
> 
> According to your comments, this the final patch. 

this only lets you get RUSAGE_SELF data for the target... for many 
processes it's more important to get the RUSAGE_CHILDREN data... and 
really i'm having a hard time imagining a use for this code which on 
further inspection doesn't eventually blow up to the requirements of a 
proper accounting subsystem... (of which i understand there are two or 
three competining implementations in progress?)

do you have a use case for this new code?

-dean
