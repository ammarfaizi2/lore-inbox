Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264820AbUETBbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264820AbUETBbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 21:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264822AbUETBbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 21:31:40 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:46260 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264820AbUETBbj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 21:31:39 -0400
Subject: Re: Random file I/O regressions in 2.6 [patch+results]
From: Ram Pai <linuxram@us.ibm.com>
To: Alexey Kopytov <alexeyk@mysql.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au, peter@mysql.com,
       linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <200405200506.03006.alexeyk@mysql.com>
References: <200405022357.59415.alexeyk@mysql.com>
	 <1084480888.22208.26.camel@dyn319386.beaverton.ibm.com>
	 <1084815010.13559.3.camel@localhost.localdomain>
	 <200405200506.03006.alexeyk@mysql.com>
Content-Type: text/plain
Organization: 
Message-Id: <1085016663.2941.10.camel@dyn319009bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 May 2004 18:31:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-19 at 18:06, Alexey Kopytov wrote:
> Ram Pai wrote:
> 
> >Attached the cleaned up patch and the performance results of the patch.
> >
> >Overall Observation:
> >        1.Small improvement with iozone with the patch, and overall
> >                        much better performance than 2.4
> >        2.Small/neglegible improvement with DSS workload.
> >        3.Negligible impact with sysbench, but results worser than
> >                        2.4 kernels
> 
> Ram, can you clarify the status of this patch please?
> 
> I ran the same sysbench test on my hardware with patched 2.6.6 and got 
> 122.2348s execution time, i.e. almost the same results as in the original 
> tests. Is this patch an intermediate step to improve the sysbench workload on 
> 2.6, or it just addresses another problem?

this patch by itself does not address your problem. Your problem is
better addressed by Andrew's 'readahead-private' patch.

However; this patch applied on top of Andrew's 'readahead-private' patch
may get you some extra performance.

Can you confirm this please?
RP



