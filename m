Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263633AbSIQF1I>; Tue, 17 Sep 2002 01:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263634AbSIQF1I>; Tue, 17 Sep 2002 01:27:08 -0400
Received: from packet.digeo.com ([12.110.80.53]:49084 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263633AbSIQF1H>;
	Tue, 17 Sep 2002 01:27:07 -0400
Message-ID: <3D86BE4F.75C9B6CC@digeo.com>
Date: Mon, 16 Sep 2002 22:31:59 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-mm@kvack.org, hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: dbench on tmpfs OOM's
References: <20020917044317.GZ2179@holomorphy.com> <3D86B683.8101C1D1@digeo.com> <20020917051501.GM3530@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Sep 2002 05:32:00.0428 (UTC) FILETIME=[8BE1D6C0:01C25E0B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> William Lee Irwin III wrote:
> >> MemTotal:     32107256 kB
> >> MemFree:      27564648 kB
> 
> On Mon, Sep 16, 2002 at 09:58:43PM -0700, Andrew Morton wrote:
> > I'd be suspecting that your node fallback is bust.
> > Suggest you add a call to show_free_areas() somewhere; consider
> > exposing the full per-zone status via /proc with a proper patch.
> 
> I went through the nodes by hand. It's just a run of the mill
> ZONE_NORMAL OOM coming out of the GFP_USER allocation. None of
> the highmem zones were anywhere near ->pages_low.
> 

erk.  Why is shmem using GFP_USER?

mnm:/usr/src/25> grep page_address mm/shmem.c
mnm:/usr/src/25>
