Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbTJOXYo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 19:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbTJOXYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 19:24:44 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:5339 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262536AbTJOXYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 19:24:43 -0400
Date: Thu, 16 Oct 2003 01:24:40 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-ID: <20031015232440.GU17986@fs.tum.de>
References: <20031015225055.GS17986@fs.tum.de> <20031015161251.7de440ab.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031015161251.7de440ab.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 04:12:51PM -0700, Andrew Morton wrote:
>...
> They are small concerns really, but it does make one wonder why we should
> not make this change unconditional: just switch the kernel to -Os?
> 
> Does anyone have any (non-micro-)benchmark results which say this is a bad
> idea?

No benchmarks, only arguments:

- it's less tested (there might be miscompilations in some part of the 
  kernel with some supported compilers)
- there might be fast path code somewhere in the kernel that becomes
  significantely slower with -Os
- I've already seen a report for an ICE in gcc 2.95 of a user compiling
  kernel 2.4 with -Os [1]

cu
Adrian

[1] http://bugs.debian.org/213497

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

