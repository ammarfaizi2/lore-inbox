Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750853AbVLKTso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbVLKTso (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 14:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750851AbVLKTso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 14:48:44 -0500
Received: from ns2.suse.de ([195.135.220.15]:34261 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750848AbVLKTsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 14:48:43 -0500
Date: Sun, 11 Dec 2005 20:48:40 +0100
From: Andi Kleen <ak@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-mm@kvack.org, Andi Kleen <ak@suse.de>
Subject: Re: [RFC 3/6] Make nr_pagecache a per zone counter
Message-ID: <20051211194840.GU11190@wotan.suse.de>
References: <20051210005440.3887.34478.sendpatchset@schroedinger.engr.sgi.com> <20051210005456.3887.94412.sendpatchset@schroedinger.engr.sgi.com> <20051211183241.GD4267@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051211183241.GD4267@dmt.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> By the way, why does nr_pagecache needs to be an atomic variable on UP systems?

At least on X86 UP atomic doesn't use the LOCK prefix and is thus quite
cheap. I would expect other architectures who care about UP performance
(= not IA64) to be similar.

-Andi
