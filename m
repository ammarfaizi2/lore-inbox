Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbSLSBYF>; Wed, 18 Dec 2002 20:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267502AbSLSBYF>; Wed, 18 Dec 2002 20:24:05 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:34780 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S267500AbSLSBYD>; Wed, 18 Dec 2002 20:24:03 -0500
Date: Wed, 18 Dec 2002 17:20:02 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 15000+ processes -- poor performance ?!
In-Reply-To: <20021219012549.GK31800@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0212181717510.7848-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I wasn't sure of the cause, but I've seen this as far back as 2.2 I
had a machine trying to run 2000 processes under 2.2 and 2.4.0 (after
upping the 2.2 kernel limit) and top would cost me ~40% throughput on the
machine (while claiming it was useing ~5% of the CPU)

David Lang

 On Wed, 18 Dec 2002, William Lee Irwin III wrote:

> Date: Wed, 18 Dec 2002 17:25:49 -0800
> From: William Lee Irwin III <wli@holomorphy.com>
> To: David Lang <dlang@diginsite.com>
> Cc: Till Immanuel Patzschke <tip@inw.de>,
>      lse-tech <lse-tech@lists.sourceforge.net>,
>      "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> Subject: Re: 15000+ processes -- poor performance ?!
>
> On Wed, Dec 18, 2002 at 05:12:41PM -0800, David Lang wrote:
> > also top is very inefficant with large numbers of processes. use vmstat
> > or cat out the files in /proc to get the info more efficiantly (it won't
> > get you per process info, but it son't cause the interferance with your
> > desired load that top gives you.)
>
> It's mostly just the fact top(1) doesn't scan /proc/ incrementally and
> that proc_pid_readdir() is quadratic in the number of tasks.
>
>
> Bill
>
