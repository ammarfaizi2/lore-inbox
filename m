Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVBXBzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVBXBzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 20:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261738AbVBXBzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 20:55:48 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:58508 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261733AbVBXBzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 20:55:43 -0500
Message-ID: <421D3448.7050209@sgi.com>
Date: Wed, 23 Feb 2005 17:56:24 -0800
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: Kaigai Kohei <kaigai@ak.jp.nec.com>, akpm@osdl.org,
       lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net, tim@physik3.uni-rostock.de,
       erikj@subway.americas.sgi.com, limin@dbear.engr.sgi.com,
       jbarnes@sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
References: <42168D9E.1010900@sgi.com>	<20050218171610.757ba9c9.akpm@osdl.org>	<421993A2.4020308@ak.jp.nec.com>	<421B955A.9060000@sgi.com>	<421C2B99.2040600@ak.jp.nec.com> <20050223172551.6771ce7a.pj@sgi.com>
In-Reply-To: <20050223172551.6771ce7a.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I think the microbenchmarking your link provides is irrelevant.
Your link provides benchmarking of doing a fork.

However, we are talking about inserting a callback routine
in a fork and/or an exit. The overhead is a function
call and time spent in the routine. The callback routine
can be configured to "do {} while (0)" if a certain CONFIG
flag is not set.

Thanks,
  - jay

Paul Jackson wrote:
>>So, I think such a fork/execve/exit hooks is harmless now.
> 
> 
> I don't recall seeing any microbenchmarking of the impact on fork/exit
> of such hooks.  You might find such a benchmark in lmbench, or at
> http://bulk.fefe.de/scalability/.
> 

