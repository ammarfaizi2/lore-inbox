Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275248AbTHMQPF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 12:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275239AbTHMQPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 12:15:05 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:48321
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S275248AbTHMQPB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 12:15:01 -0400
Date: Wed, 13 Aug 2003 12:15:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Jim Carter <jimc@math.ucla.edu>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Jamie Lokier <jamie@shareable.org>,
       Matt Mackall <mpm@selenic.com>, James Morris <jmorris@intercode.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, davem@redhat.com
Subject: Re: i810_rng.o on various Dell models
Message-ID: <20030813161459.GA19667@gtf.org>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030811020919.GD10446@mail.jlokier.co.uk> <20030813035257.GB1244@think> <Pine.LNX.4.53.0308130830170.3016@xena.cft.ca.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308130830170.3016@xena.cft.ca.us>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 08:44:56AM -0700, Jim Carter wrote:
> In response to a message of Theodore Ts'o <tytso@mit.edu> dated 2003-08-12
> (Subject was: [RFC][PATCH] Make cryptoapi non-optional?):
> 
> I've recently come to the unpleasant conclusion that the reason i810_rng.o
> (kernel 2.4.20) doesn't load on various Dell models (on none of the
> numerous Dell models I've tried) is that the motherboards actually lack the
> hardware random number generator.

This is correct:  Intel dropped the RNG after the first few releases of
their ICH chipset (which is now up to ICH5).  Not much Dell can do about
it.

Intel's RNG was slow anyway, compared to the AMG and now VIA RNGs, so
you didn't want it anyway :)  I really like VIA's "xstore", which is an
RNG implemented via a CPU instruction.  That way you don't need a kernel
driver at all, really.

	Jeff



