Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030239AbWAXAkH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030239AbWAXAkH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 19:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWAXAkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 19:40:06 -0500
Received: from ns1.suse.de ([195.135.220.2]:43403 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030239AbWAXAkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 19:40:05 -0500
From: Andi Kleen <ak@suse.de>
To: "Ray Bryant" <raybry@mpdtxmail.amd.com>
Subject: Re: [PATCH/RFC] Shared page tables
Date: Tue, 24 Jan 2006 01:39:46 +0100
User-Agent: KMail/1.8.2
Cc: "Dave McCracken" <dmccr@us.ibm.com>, "Robin Holt" <holt@sgi.com>,
       "Hugh Dickins" <hugh@veritas.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Linux Memory Management" <linux-mm@kvack.org>
References: <A6D73CCDC544257F3D97F143@[10.1.1.4]> <200601231758.08397.raybry@mpdtxmail.amd.com> <200601231816.38942.raybry@mpdtxmail.amd.com>
In-Reply-To: <200601231816.38942.raybry@mpdtxmail.amd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601240139.46751.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 January 2006 01:16, Ray Bryant wrote:
> On Monday 23 January 2006 17:58, Ray Bryant wrote:
> <snip>
> 
> > ... And what kind of alignment constraints do we end up
> > under in order to make the sharing happen?   (My guess would be that there
> > aren't any such constraints (well, page alignment.. :-)  if we are just
> > sharing pte's.)
> >
> 
> Oh, obviously that is not right as you have to share full pte pages.   So on 
> x86_64 I'm guessing one needs 2MB alignment in order to get the sharing to
> kick in, since a pte page maps 512 pages of 4 KB each.

The new randomized mmaps will likely actively sabotate such alignment. I just
added them for x86-64.

-Andi
