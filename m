Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263599AbSIQEyC>; Tue, 17 Sep 2002 00:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263613AbSIQEyC>; Tue, 17 Sep 2002 00:54:02 -0400
Received: from packet.digeo.com ([12.110.80.53]:1468 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263599AbSIQEyB>;
	Tue, 17 Sep 2002 00:54:01 -0400
Message-ID: <3D86B683.8101C1D1@digeo.com>
Date: Mon, 16 Sep 2002 21:58:43 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-mm@kvack.org, akpm@zip.com.au, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: dbench on tmpfs OOM's
References: <20020917044317.GZ2179@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Sep 2002 04:58:44.0047 (UTC) FILETIME=[E5F245F0:01C25E06]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> ...
> MemTotal:     32107256 kB
> MemFree:      27564648 kB

I'd be suspecting that your node fallback is bust.

Suggest you add a call to show_free_areas() somewhere; consider
exposing the full per-zone status via /proc with a proper patch.
