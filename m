Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbTDWRqZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 13:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264168AbTDWRqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 13:46:25 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:16316 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264164AbTDWRqW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 13:46:22 -0400
Date: Wed, 23 Apr 2003 10:47:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] HT scheduler, sched-2.5.68-B2
Message-ID: <1535810000.1051120075@flay>
In-Reply-To: <Pine.LNX.4.44.0304231816210.10779-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0304231816210.10779-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  - turn off the more agressive idle-steal variant. This could fix the
>    low-load regression reported by Martin J. Bligh.

Yup, that fixed it (I tested just your first version with just that
bit altered).

Thanks! 

M.


 DISCLAIMER: SPEC(tm) and the benchmark name SDET(tm) are registered
trademarks of the Standard Performance Evaluation Corporation. This 
benchmarking was performed for research purposes only, and the run results
are non-compliant and not-comparable with any published results.

Results are shown as percentages of the first set displayed

SDET 1  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.7%
                2.5.68-ht        72.9%         1.8%
           2.5.68-ht-pasv        98.4%         3.4%

SDET 2  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         2.8%
                2.5.68-ht        73.7%         2.1%
           2.5.68-ht-pasv       100.4%         1.0%

SDET 4  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         1.0%
                2.5.68-ht        62.5%        47.0%
           2.5.68-ht-pasv        99.7%         2.8%

SDET 8  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.6%
                2.5.68-ht        92.6%         1.0%
           2.5.68-ht-pasv       101.2%         1.7%

SDET 16  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.1%
                2.5.68-ht       100.0%         0.5%
           2.5.68-ht-pasv       101.1%         0.4%

SDET 32  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.4%
                2.5.68-ht        99.1%         0.6%
           2.5.68-ht-pasv        99.6%         0.6%

SDET 64  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.2%
                2.5.68-ht        99.0%         0.1%
           2.5.68-ht-pasv       100.3%         0.4%

SDET 128  (see disclaimer)
                           Throughput    Std. Dev
                   2.5.68       100.0%         0.1%
                2.5.68-ht        99.0%         0.1%
           2.5.68-ht-pasv        99.2%         1.3%


