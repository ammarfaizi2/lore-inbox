Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263570AbSIQD1P>; Mon, 16 Sep 2002 23:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263576AbSIQD1P>; Mon, 16 Sep 2002 23:27:15 -0400
Received: from holomorphy.com ([66.224.33.161]:35042 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263570AbSIQD1P>;
	Mon, 16 Sep 2002 23:27:15 -0400
Date: Mon, 16 Sep 2002 20:29:15 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: false NUMA OOM
Message-ID: <20020917032915.GL3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, akpm@zip.com.au
References: <20020917025035.GY2179@holomorphy.com> <3D869EAF.663B6EC3@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D869EAF.663B6EC3@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
+       for (type = classzone - first_classzone; type >= 0; --type)
+               for_each_pgdat(pgdat) {
+                       zone = pgdat->node_zones + type;

On Mon, Sep 16, 2002 at 08:17:03PM -0700, Andrew Morton wrote:
> Well you'd want to start with (and prefer) the local node's zones?
> I'm also wondering whether one shouldn't just poke a remote kswapd
> and wait.

I just sort of rearranged what was already there so it wouldn't die
quite so blatantly (i.e. minimal fix). Those are also sound methods.


Cheers,
Bill
