Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289628AbSAOT6K>; Tue, 15 Jan 2002 14:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289659AbSAOT6A>; Tue, 15 Jan 2002 14:58:00 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:62011 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289628AbSAOT5v>; Tue, 15 Jan 2002 14:57:51 -0500
Date: Tue, 15 Jan 2002 14:57:47 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] zerocopy pipe, new version
Message-ID: <20020115145747.F6853@redhat.com>
In-Reply-To: <002701c19638$400f15f0$010411ac@local> <011001c19de8$ec1d4800$1cdb0209@diz.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <011001c19de8$ec1d4800$1cdb0209@diz.watson.ibm.com>; from frankeh@watson.ibm.com on Tue, Jan 15, 2002 at 12:20:25PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 12:20:25PM -0500, Hubertus Franke wrote:
> Conclusion
> ----------
> Manfred Spraul's new zero copy patch showed a very good performance
> improvement for pipeflex as well as grep on both 2-way and 1-way.
> By adding our large pipe support, performance improvement up to
> 42% for pipeflex and 96% for grep benchmarks on 2-way systems.
> No significant different has been observed for lmbench on 1-way systems.
> The right way to configure the system than would be for UP and 1-way to
> set the buffer size by default to 4K while for the SMP larger pipe buffers
> should be encouraged.

Any conclusions are incomplete without mentioning the serious (30%+) 
degredation on UP systems under a good chunk of the benchmarks.  Such 
aspects of the patch make it unsuitable as is for both the mainstream 
and vendor kernels.

		-ben
