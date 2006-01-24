Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWAXOz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWAXOz0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 09:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWAXOzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 09:55:25 -0500
Received: from ns2.suse.de ([195.135.220.15]:9966 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750945AbWAXOzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 09:55:25 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] [SMP] reduce size of percpudata, and make sure per_cpu(object, not_possible_cpu) cause an invalid memory reference
Date: Tue, 24 Jan 2006 15:53:50 +0100
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org, shai@scalex86.org, kiran@scalex86.org,
       pravins@calsoftinc.com
References: <43CE4C98.76F0.0078.0@novell.com> <20060124005806.7e9ab02e.akpm@osdl.org> <43D63DB5.3010601@cosmosbay.com>
In-Reply-To: <43D63DB5.3010601@cosmosbay.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601241553.50874.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 January 2006 15:46, Eric Dumazet wrote:

> As some architectures (x86_64) are now allocating cpudata only on possible
> cpus, we (kernel developers on x86 machines) should make sure that x86 does
> a similar thing to find bugs. This is important that this patch has some
> exposure in -mm for some time, some places must now use :

The for_each_cpu changes should be actually merged ASAP because x86-64 
needs them (or maybe i should back out that change until the kernel is ready?)
But it really saves a lot of memory - several MB on a distro kernel which is 
compiled with NR_CPUS==128.

-Andi
