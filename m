Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275324AbTHMSxS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 14:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275351AbTHMSxR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 14:53:17 -0400
Received: from mail.suse.de ([213.95.15.193]:8466 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S275324AbTHMSxO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 14:53:14 -0400
Date: Wed, 13 Aug 2003 20:53:12 +0200
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test3-mm1: scheduling while atomic (ext3?)
Message-ID: <20030813185312.GI21081@wotan.suse.de>
References: <20030813042544.5064b3f4.akpm@osdl.org.suse.lists.linux.kernel> <1060774803.8008.24.camel@localhost.localdomain.suse.lists.linux.kernel> <p7365l17o70.fsf@oldwotan.suse.de> <1060778924.8008.39.camel@localhost.localdomain> <20030813131457.GD32290@wotan.suse.de> <1060783794.8008.62.camel@dhcp23.swansea.linux.org.uk> <20030813142055.GC9179@wotan.suse.de> <1060788009.8957.5.camel@dhcp23.swansea.linux.org.uk> <20030813153235.GB21081@wotan.suse.de> <1060800263.9130.29.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060800263.9130.29.camel@dhcp23.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 07:44:24PM +0100, Alan Cox wrote:
> On Mer, 2003-08-13 at 16:32, Andi Kleen wrote:
> > The AMD slides assume all very big data sets ;-)
> > 
> > I would recommend to remove it.
> 
> I'll do some timings when I get a moment - the prefetching mmx copy

Microbenchmarks are useless for this. You have to bench the users too,
otherwise you don't recognize the additional cache misses.

> was a win (and faster than the others for small data as well as large
> on the K7-550 (really a K7 not "Athlon" 8)) way back when.

Possible. In my experience the best copy functions vary widly between
different steppings. Just optimizing for a single one is probably
not a good idea, especially not for an very old one 
(except when you add dynamic patches for the different steppings, but
then it quickly gets ugly with too many variants)

When in doubt use the more simple function.

-Andi
