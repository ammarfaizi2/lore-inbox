Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317508AbSGTUwD>; Sat, 20 Jul 2002 16:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317511AbSGTUwD>; Sat, 20 Jul 2002 16:52:03 -0400
Received: from holomorphy.com ([66.224.33.161]:64916 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317508AbSGTUwC>;
	Sat, 20 Jul 2002 16:52:02 -0400
Date: Sat, 20 Jul 2002 13:54:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Robert Love <rml@tech9.net>, akpm@zip.com.au, torvalds@transmeta.com,
       riel@conectiva.com.br, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] for_each_pgdat
Message-ID: <20020720205454.GF1096@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Robert Love <rml@tech9.net>, akpm@zip.com.au,
	torvalds@transmeta.com, riel@conectiva.com.br,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1027196535.1116.773.camel@sinai> <236911771.1027172579@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <236911771.1027172579@[10.10.2.3]>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, Robert Love wrote:
>> This patch implements for_each_pgdat(pg_data_t *) which is a helper
>> macro to cleanup code that does a loop of the form:

On Sat, Jul 20, 2002 at 01:43:00PM -0700, Martin J. Bligh wrote:
> If you're going to do that (which I think is a good idea) can you
> rename node_next to pgdat_next, as it often has nothing to do with
> nodes whatsoever (discontigmem on a non-NUMA machine, or even more
> confusingly a NUMA machine which is discontig within a node)? I'll
> attatch a patch below, but it conflicts what what you're doing
> horribly, and it's even easier to do after your abtraction ...

Another option would be to convert pgdats to using list.h, which would
make things even prettier IMHO. After wrapping the list iterations it's
actually not difficult to swizzle the list linkage out from underneath.

And yes, s/pgdat/physcontig_region/ or whatever would make the name
match the intended usage.



Cheers,
Bill
