Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268127AbUHFNHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268127AbUHFNHZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268128AbUHFNHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:07:24 -0400
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:63933 "EHLO
	certainkey.com") by vger.kernel.org with ESMTP id S268127AbUHFNHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:07:23 -0400
Date: Fri, 6 Aug 2004 09:03:03 -0400
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Michael Halcrow <lkml@halcrow.us>, James Morris <jmorris@redhat.com>,
       "David S. Miller" <davem@redhat.com>, cryptoapi@lists.logix.cz,
       Michal Ludvig <mludvig@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]
Message-ID: <20040806130303.GF23994@certainkey.com>
References: <20040805194914.GC23994@certainkey.com> <Xine.LNX.4.44.0408052245380.20516-100000@dhcp83-76.boston.redhat.com> <20040806020313.GA21309@halcrow.us> <Pine.LNX.4.58.0408052155180.24588@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408052155180.24588@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2004 at 09:58:58PM -0700, Linus Torvalds wrote:
> So I'd strongly suggest against doing any "raw crypto access". Zero-copy
> is often just a complicated way of doing things slowly, all in the name of
> some benchmark performance.

I hear you, these are all desirable things and I hate trying to be the black
sheep - but would random.c make sense in being the exception since the
outward looking interfaces (random_write for example) all use const char*
type as arguments?

Keeping the existing random.c interface and using crypto-api's scatter-gather
interface are kind of contradictory ... or and I really missing something
important (likely)?

JLC
