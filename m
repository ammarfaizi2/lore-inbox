Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261847AbSKCVQ4>; Sun, 3 Nov 2002 16:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262415AbSKCVQ4>; Sun, 3 Nov 2002 16:16:56 -0500
Received: from holomorphy.com ([66.224.33.161]:53648 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261847AbSKCVQ4>;
	Sun, 3 Nov 2002 16:16:56 -0500
Date: Sun, 3 Nov 2002 13:22:04 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@digeo.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Hot/cold allocation -- swsusp can not handle hot pages
Message-ID: <20021103212204.GP23425@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@digeo.com>,
	kernel list <linux-kernel@vger.kernel.org>
References: <20021102181900.GA140@elf.ucw.cz> <20021102184612.GI23425@holomorphy.com> <20021102202208.GC18576@atrey.karlin.mff.cuni.cz> <3DC44839.A3AEAE41@digeo.com> <20021103200809.GC27271@elf.ucw.cz> <20021103205206.GN23425@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103205206.GN23425@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 12:52:06PM -0800, William Lee Irwin III wrote:
> static void empty_pageset(struct zone *zone, struct per_cpu_pages *pcp)
> {
> 	pcp->batch = pcp->low = pcp->high = 1;
> 	pcp->count -= free_pages_bulk(zone, pcp->batch, &pcp->list, 0);
> }

Should be
 	pcp->count -= free_pages_bulk(zone, pcp->count, &pcp->list, 0);


Bill
