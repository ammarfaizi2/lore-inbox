Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272871AbTHEQhC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272872AbTHEQhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:37:02 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:46755 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S272871AbTHEQhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:37:00 -0400
Date: Tue, 5 Aug 2003 18:36:48 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Ducrot Bruno <poup@poupinou.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL] sanitize power management config menus, take two
Message-ID: <20030805163648.GG18982@louise.pinerecords.com>
References: <20030805072631.GC5876@louise.pinerecords.com> <20030805161117.GA1511@poupinou.org> <20030805161505.GD18982@louise.pinerecords.com> <20030805162428.GB1511@poupinou.org> <20030805162604.GF18982@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030805162604.GF18982@louise.pinerecords.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [szepe@pinerecords.com]
> 
> > [poup@poupinou.org]
> > 
> > > o  only enable cpufreq options if power management is selected
> > > o  don't put cpufreq options in a separate submenu
> > 
> > Yes, but what I do not understand is why cpufreq need power management.
> 
> Because it is a power management option. :)
> 
> CONFIG_PM is a dummy option, it does not link any code into the kernel
> by itself.

Ooops, I ain't right. :)

There actually seems to be code that depends on CONFIG_PM,
particularly so on arches other that x86, so the 'depends
on PM' clause for cpufreq is indeed bogus.

Thanks for pointing this out, I'll post a fixed patch.

-- 
Tomas Szepe <szepe@pinerecords.com>
