Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267641AbTBUTTC>; Fri, 21 Feb 2003 14:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267645AbTBUTTC>; Fri, 21 Feb 2003 14:19:02 -0500
Received: from holomorphy.com ([66.224.33.161]:42661 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267641AbTBUTTB>;
	Fri, 21 Feb 2003 14:19:01 -0500
Date: Fri, 21 Feb 2003 11:27:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@imladris.surriel.com>, Andrew Morton <akpm@digeo.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, dmccr@us.ibm.com
Subject: Re: [Lse-tech] Re: Performance of partial object-based rmap
Message-ID: <20030221192706.GE10401@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@imladris.surriel.com>,
	Andrew Morton <akpm@digeo.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
	dmccr@us.ibm.com
References: <7490000.1045715152@[10.10.2.4]> <278890000.1045791857@flay> <20030220190819.531e119d.akpm@digeo.com> <Pine.LNX.4.50L.0302210020560.2329-100000@imladris.surriel.com> <20030220194759.15d5d932.akpm@digeo.com> <Pine.LNX.4.50L.0302210117490.2329-100000@imladris.surriel.com> <20030221100010.GB10401@holomorphy.com> <20030221191538.GD10401@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221191538.GD10401@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 02:00:10AM -0800, William Lee Irwin III wrote:
>> nr_page_table_pages                  689
>> which amounts to 2756KB RAM used for PTE's, demonstrating large
> Pagetables are also grossly fragmented. From the same sample:
> nr_reverse_maps                   156027
> To preempt the FAQ, this is the number of reverse mappings performed,
> where one is done for every instantiated non-swap PTE.

ARGH too early in the morning.

$ echo $(( (100*156027.0)/(689*1024) ))
22.11467593432511
percent utilization

or

$ echo $(( 156027.0/689 ))            
226.45428156748912

PTE's per pagetable page.


-- wli
