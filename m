Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263631AbSIQFPL>; Tue, 17 Sep 2002 01:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263632AbSIQFPL>; Tue, 17 Sep 2002 01:15:11 -0400
Received: from holomorphy.com ([66.224.33.161]:62434 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S263631AbSIQFPG>;
	Tue, 17 Sep 2002 01:15:06 -0400
Date: Mon, 16 Sep 2002 22:15:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-mm@kvack.org, akpm@zip.com.au, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: dbench on tmpfs OOM's
Message-ID: <20020917051501.GM3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org, akpm@zip.com.au,
	hugh@veritas.com, linux-kernel@vger.kernel.org
References: <20020917044317.GZ2179@holomorphy.com> <3D86B683.8101C1D1@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D86B683.8101C1D1@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> MemTotal:     32107256 kB
>> MemFree:      27564648 kB

On Mon, Sep 16, 2002 at 09:58:43PM -0700, Andrew Morton wrote:
> I'd be suspecting that your node fallback is bust.
> Suggest you add a call to show_free_areas() somewhere; consider
> exposing the full per-zone status via /proc with a proper patch.

I went through the nodes by hand. It's just a run of the mill
ZONE_NORMAL OOM coming out of the GFP_USER allocation. None of
the highmem zones were anywhere near ->pages_low.


Cheers,
Bill
