Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291157AbSBMAdr>; Tue, 12 Feb 2002 19:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291273AbSBMAdi>; Tue, 12 Feb 2002 19:33:38 -0500
Received: from rj.SGI.COM ([204.94.215.100]:21199 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S291222AbSBMAdZ>;
	Tue, 12 Feb 2002 19:33:25 -0500
Date: Tue, 12 Feb 2002 16:33:23 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
Message-ID: <20020212163323.A768043@sgi.com>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C639060.A68A42CA@zip.com.au> <3C6791C0.63CA2677@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6791C0.63CA2677@zip.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 01:41:20AM -0800, Andrew Morton wrote:
> Also, here's a patch which fixes the /bin/sync livelock in
> write_unlocked_buffers().  It simply bales out after writing
> all the buffers which were dirty at the time the function
> was called, rather than keeping on trying to write buffers
> until the list is empty.

I've also seen this issue when I start multiple mkfs commands (10 in
parallel basically make the system useless), but the patch helped.
Any chance it will get into 2.4?

Thanks,
Jesse
