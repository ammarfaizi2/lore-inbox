Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264438AbTDXVME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTDXVMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:12:03 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:22203 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264438AbTDXVMA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:12:00 -0400
Date: Thu, 24 Apr 2003 14:13:25 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.68-mm2
Message-ID: <1661460000.1051218805@flay>
In-Reply-To: <20030423233954.D9036@redhat.com>
References: <20030423012046.0535e4fd.akpm@digeo.com><18400000.1051109459@[10.10.2.4]> <20030423144648.5ce68d11.akpm@digeo.com> <1565150000.1051134452@flay> <20030423233954.D9036@redhat.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> The performance improvement was about 25% of systime according to my 
>> measurements - I don't call that insignificant.
> 
> Never, ever use changes in system time as a justification for a patch.  We 
> all know that Linux's user/system time accounting is patently unreliable.  

Mmmm. I'm not particularly convinced by that ... I do 5 runs for every 
benchmark and compare the results, and it seems very consistent to me. 
For kernbench, it's interesting to look at system time - but obviously
keeping an eye on elapsed time as well, particularly for things like
scheduler patches.

> Remember Nyquist?  Talk to me about differences in wall clock and your 
> comments will be more interesting.

OK, well then you need to look at something that's not totally dominated
by gcc anyway. I know everyone hates SDET as it's "closed" but I'll try
to rerun with aim7 at some point. A real 20% improvement in throughput
is not to be sniffed at ...

DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.7%
           2.5.68-objrmap       105.7%         0.4%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         2.8%
           2.5.68-objrmap       108.2%         0.7%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         1.0%
           2.5.68-objrmap       112.0%         1.4%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.6%
           2.5.68-objrmap       122.8%         1.3%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.1%
           2.5.68-objrmap       117.3%         0.8%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.4%
           2.5.68-objrmap       118.5%         0.4%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.2%
           2.5.68-objrmap       121.2%         0.3%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.1%
           2.5.68-objrmap       118.6%         0.2%


