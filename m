Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267532AbSLSBso>; Wed, 18 Dec 2002 20:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267535AbSLSBso>; Wed, 18 Dec 2002 20:48:44 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:41348 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S267532AbSLSBsn>; Wed, 18 Dec 2002 20:48:43 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Robert Love <rml@tech9.net>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Date: Wed, 18 Dec 2002 17:44:46 -0800 (PST)
Subject: Re: 15000+ processes -- poor performance ?!
In-Reply-To: <1040262178.855.106.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0212181743350.7848-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my case I will still be running thousands of processes, so I have to
just teach everyone not to use top instead.

David Lang

On 18 Dec 2002, Robert Love wrote:

> Date: 18 Dec 2002 20:42:58 -0500
> From: Robert Love <rml@tech9.net>
> To: David Lang <dlang@diginsite.com>
> Cc: William Lee Irwin III <wli@holomorphy.com>,
>      Till Immanuel Patzschke <tip@inw.de>,
>      lse-tech <lse-tech@lists.sourceforge.net>,
>      "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
> Subject: Re: 15000+ processes -- poor performance ?!
>
> On Wed, 2002-12-18 at 20:20, David Lang wrote:
> > Ok, I wasn't sure of the cause, but I've seen this as far back as 2.2 I
> > had a machine trying to run 2000 processes under 2.2 and 2.4.0 (after
> > upping the 2.2 kernel limit) and top would cost me ~40% throughput on the
> > machine (while claiming it was useing ~5% of the CPU)
>
> Yah a lot of it is like William is saying... you just do not want to
> read multiple files for each process in /proc when you have a kajillion
> processes, and that is what top does.  Over and over.
>
> Work has gone into 2.5 to make this a lot better.. If you use threads
> with NPTL in 2.5, a lot of this is resolved, since the sub-threads will
> not show up in as /proc/#/ entries.
>
> 	Robert Love
>
