Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263613AbSIQE6c>; Tue, 17 Sep 2002 00:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263614AbSIQE6c>; Tue, 17 Sep 2002 00:58:32 -0400
Received: from franka.aracnet.com ([216.99.193.44]:45256 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S263613AbSIQE6b>; Tue, 17 Sep 2002 00:58:31 -0400
Date: Mon, 16 Sep 2002 22:01:46 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, William Lee Irwin III <wli@holomorphy.com>
cc: linux-mm@kvack.org, akpm@zip.com.au, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: dbench on tmpfs OOM's
Message-ID: <210772234.1032213704@[10.10.2.3]>
In-Reply-To: <3D86B683.8101C1D1@digeo.com>
References: <3D86B683.8101C1D1@digeo.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> ...
>> MemTotal:     32107256 kB
>> MemFree:      27564648 kB
> 
> I'd be suspecting that your node fallback is bust.
> 
> Suggest you add a call to show_free_areas() somewhere; consider
> exposing the full per-zone status via /proc with a proper patch.

Won't /proc/meminfo.numa show that? Or do you mean something
else by "full per-zone status"?

Looks to me like it's just out of low memory:

> LowFree:          1424 kB

There is no low memory on anything but node 0 ...

M.

