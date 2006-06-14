Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964887AbWFNFqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964887AbWFNFqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 01:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWFNFqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 01:46:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:9412 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964887AbWFNFqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 01:46:12 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-kernel@vger.kernel.org,
       catalin.marinas@gmail.com
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
References: <20060611112156.8641.94787.stgit@localhost.localdomain>
	<84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com>
	<b0943d9e0606120111v310f8556k30b6939d520d56d8@mail.gmail.com>
	<Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
	<20060612105345.GA8418@elte.hu>
	<b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com>
	<20060612192227.GA5497@elte.hu>
	<Pine.LNX.4.58.0606130850430.15861@sbz-30.cs.Helsinki.FI>
	<20060613072646.GA17978@elte.hu>
	<b0943d9e0606130349s24614bbcia6a650342437d3d1@mail.gmail.com>
	<20060614040707.GA7503@elte.hu>
From: Andi Kleen <ak@suse.de>
Date: 14 Jun 2006 07:46:02 +0200
In-Reply-To: <20060614040707.GA7503@elte.hu>
Message-ID: <p73fyi8qoh1.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:
> But it's not just about the amount of false negatives, but also about 
> the overhead of scanning. You are concentrated on embedded systems with 
> small RAM - but most of the testers will be running this with at last 
> 1GB of RAM - which is _alot_ of memory to scan.

Most of this should be normally in page cache which doesn't need to be scanned?

There might be some extreme loads with a lot more kernel data, but they
are probably rare.

-Andi 
7
