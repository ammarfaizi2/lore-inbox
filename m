Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbUDUU70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUDUU70 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 16:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbUDUU7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 16:59:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25534 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263365AbUDUU7X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 16:59:23 -0400
Date: Wed, 21 Apr 2004 18:00:42 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Satoshi Oshima <oshima@sdl.hitachi.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA64 Linux VM performance woes
Message-ID: <20040421210042.GD16891@logos.cnet>
References: <JT20040421213923.40329203@sdl.hitachi.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JT20040421213923.40329203@sdl.hitachi.co.jp>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 09:39:23PM +0900, Satoshi Oshima wrote:
> Hello, Michael and all.
> 
> We have realized the same kind of performance issue. 
> In our case it is not an IA64 huge scale system but an IA32
> server system.
> 
> In our experiment, we see file I/O throughput decline on 
> the server with over 8GByte memory. Kernel versions we use 
> are 2.6.0 and Red Hat AS3. We show our experiment.
> 
> Below is our hardware configuration and test bench.
> 
> CPUs: Xeon 1.6Ghz - 4way
> Memory: 12GB
> Storage: ATA 120GB
> File I/O workload generator consists of 1024 processes and 
> generates 100KByte to 5MByte file write. Using "mem=" option, 
> we change the memory recognition 2GByte to 12GB.
> 
> Below is the result ( unit: MByte/sec).
> 
>       2GB  4GB  8GB  12GB
> 2.6.0 13.1 18.5 18.4 16.1
> AS3   11.0 11.3 10.3 8.92
> 
> The result shows throughput decline occurs when the server 
> has over 8GByte memory.

Can you share the tests with us? It would be great. 

> We agree that your proposal is good idea. It reduces cache 
> memory reclaiming cost to set upper bound on number of 
> cache memory pages. 

I'm not exactly sure of the problem (others (Andrea, Andrew, etc) probably are). Still,
one useful thing would be to rerun the benchmarks on recent kernels (2.6.6-rc2, which contains a 
lot of VM rewrite and tuning). It will be interesting to know the results.

> Generally it is very difficult to build one system which 
> could handle various type of workloads well. So we hope 
> Linux would have kernel parameter tuning interface.
> 
> We would be very happy if we could share information to 
> manage large scale memory.
