Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263271AbTIAU63 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 16:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTIAU62
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 16:58:28 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:14864
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263271AbTIAU60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 16:58:26 -0400
Date: Mon, 1 Sep 2003 13:58:34 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BENCHMARK] 2.6.0-test4-mm4 with contest
Message-ID: <20030901205834.GC31760@matchmail.com>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200309011627.28052.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309011627.28052.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 04:27:28PM +1000, Con Kolivas wrote:
> contest benchmarks.
> 
> no_load:
> Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
> 2.6.0-test4          1  80      93.8    0.0     0.0     1.00
> 2.6.0-test4-mm2      1  79      93.7    0.0     0.0     1.00
> 2.6.0-test4-mm4      1  80      93.8    0.0     0.0     1.00

Regressions:
> cacherun:
> Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
> 2.6.0-test4          1  75      100.0   0.0     0.0     0.94
> 2.6.0-test4-mm2      1  75      98.7    0.0     0.0     0.95
> 2.6.0-test4-mm4      1  77      97.4    0.0     0.0     0.96
> process_load:
> Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
> 2.6.0-test4          2  108     69.4    64.0    28.7    1.35
> 2.6.0-test4-mm2      2  125     59.2    92.5    38.4    1.58
> 2.6.0-test4-mm4      2  131     56.5    104.5   41.2    1.64
> io_load:
> Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
> 2.6.0-test4          4  119     64.7    43.4    19.2    1.49
> 2.6.0-test4-mm2      4  110     70.0    35.4    16.4    1.39
> 2.6.0-test4-mm4      4  129     59.7    43.1    16.9    1.61

Improvements:
> ctar_load:
> Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
> 2.6.0-test4          3  117     67.5    1.0     5.1     1.46
> 2.6.0-test4-mm2      3  115     69.6    1.0     6.1     1.46
> 2.6.0-test4-mm4      3  99      80.8    0.0     0.0     1.24
> xtar_load:
> Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
> 2.6.0-test4          3  132     58.3    3.0     7.5     1.65
> 2.6.0-test4-mm2      3  141     54.6    3.3     7.0     1.78
> 2.6.0-test4-mm4      3  109     70.6    1.0     3.7     1.36
> io_other:
> Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
> 2.6.0-test4          2  116     67.2    48.0    21.4    1.45
> 2.6.0-test4-mm2      2  110     70.0    41.0    18.8    1.39
> 2.6.0-test4-mm4      2  111     69.4    40.8    18.8    1.39
> read_load:
> Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
> 2.6.0-test4          2  109     72.5    8.6     5.5     1.36
> 2.6.0-test4-mm2      2  106     73.6    8.3     5.6     1.34
> 2.6.0-test4-mm4      2  100     78.0    6.5     5.0     1.25
> list_load:
> Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
> 2.6.0-test4          2  97      79.4    0.0     8.2     1.21
> 2.6.0-test4-mm2      2  96      80.2    0.0     7.3     1.22
> 2.6.0-test4-mm4      2  95      80.0    0.0     7.4     1.19
> mem_load:
> Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
> 2.6.0-test4          2  101     78.2    67.0    3.0     1.26
> 2.6.0-test4-mm2      2  98      79.6    66.5    3.1     1.24
> 2.6.0-test4-mm4      2  93      84.9    65.0    3.2     1.16
> dbench_load:
> Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
> 2.6.0-test4          4  390     19.5    6.2     57.3    4.88
> 2.6.0-test4-mm2      3  242     31.8    3.0     44.2    3.06
> 2.6.0-test4-mm4      4  260     29.6    3.2     45.0    3.25

Except that mm2 is doing better with dbench...

What changed there?
