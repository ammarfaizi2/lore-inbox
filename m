Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272528AbTHPA6d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 20:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272533AbTHPA6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 20:58:33 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:12674 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272528AbTHPA6c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 20:58:32 -0400
Date: Sat, 16 Aug 2003 01:58:07 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Matt Mackall <mpm@selenic.com>, tytso@mit.edu, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030816005806.GB21356@mail.jlokier.co.uk>
References: <20030809173329.GU31810@waste.org> <Mutt.LNX.4.44.0308102317470.7218-100000@excalibur.intercode.com.au> <20030810174528.GZ31810@waste.org> <20030813032038.GA1244@think> <20030813040614.GP31810@waste.org> <20030815221211.GA4306@think> <20030815235501.GB325@waste.org> <20030815170532.06e14e89.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815170532.06e14e89.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Matt Mackall <mpm@selenic.com> wrote:
> > I'm pretty sure there was never a time when entropy
> > accounting wasn't racy let alone wrong, SMP or no (fixed in -mm, thank
> > you).
> 
> Well is has been argued that the lack of locking in the random driver is a
> "feature", adding a little more unpredictability.

Dodgy.  Does lack of locking mean users can trick /dev/random into
thinking it has more entropy than it does?  Or let them detect the
time when /dev/random gains entropy, without reading it?

> Now I don't know if that makes sense or not, but the locking certainly has
> a cost.  If it doesn't actually fix anything then that cost becomes a
> waste.

Per-cpu random pools, perhaps :)

-- Jamie
