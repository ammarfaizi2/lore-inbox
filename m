Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267453AbSLSBaU>; Wed, 18 Dec 2002 20:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267455AbSLSBaU>; Wed, 18 Dec 2002 20:30:20 -0500
Received: from holomorphy.com ([66.224.33.161]:18111 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267453AbSLSBaT>;
	Wed, 18 Dec 2002 20:30:19 -0500
Date: Wed, 18 Dec 2002 17:36:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: David Lang <dlang@diginsite.com>
Cc: Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 15000+ processes -- poor performance ?!
Message-ID: <20021219013645.GM31800@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	David Lang <dlang@diginsite.com>,
	Till Immanuel Patzschke <tip@inw.de>,
	lse-tech <lse-tech@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20021219012549.GK31800@holomorphy.com> <Pine.LNX.4.44.0212181717510.7848-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212181717510.7848-100000@dlang.diginsite.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 05:20:02PM -0800, David Lang wrote:
> Ok, I wasn't sure of the cause, but I've seen this as far back as 2.2 I
> had a machine trying to run 2000 processes under 2.2 and 2.4.0 (after
> upping the 2.2 kernel limit) and top would cost me ~40% throughput on the
> machine (while claiming it was useing ~5% of the CPU)
> David Lang

It wasn't really lying to you. The issue is that the kernel samples at
regular intervals to avoid timer reprogramming overhead. Now top(1) is
isochronous in nature as it's trying to periodically refresh, and so
it runs in lockstep with the clock interrupt, and the kernel hands back
bad numbers to top(1).


Bill
