Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030445AbWFITaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030445AbWFITaP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 15:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbWFITaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 15:30:15 -0400
Received: from wx-out-0102.google.com ([66.249.82.200]:28538 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030445AbWFITaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 15:30:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B48Jy6Ejx/ZRKeyFO653uiqBMcx5fktHKURjNtJPX0dLzOJK3kMR2EPexxuiM4EiVcULAUNxNTdQz0mkyMoIbWBnImo+McgEl8mKVv+vo4cX007N/r7yXGqTXhMI+uA7xgPMoA5L0mLbMP9efrlrD7DHd12ZYOFrK5SRYYg5WNY=
Message-ID: <4745278c0606091230g1cff8514vc6ad154acb62e341@mail.gmail.com>
Date: Fri, 9 Jun 2006 15:30:12 -0400
From: "Vishal Patil" <vishpat@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: CSCAN vs CFQ I/O scheduler benchmark results
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I ran the sysbench benchmark to compare the CSCAN I/O scheduler
against the CFQ scheduler and following are the results. The results
are interesting especially in case of sequential writes and the random
workloads

                                            Latency (seconds)

               seq            seq         seq             rnd
 rnd         rnd
               reads         writes      r + w          reads
writes      r + w
               --------------------------------------------------------------------------------------
CFQ         0.0116      0.0164      0.0107      0.1178       0.0423      0.0605

CSCAN    0.0148      0.0092      0.0169      0.1043      0.0473      0.0732


                                           Throughput (MB/seconds)

                seq            seq         seq             rnd
  rnd         rnd
                reads         writes      r + w          reads
writes      r + w

--------------------------------------------------------------------------------------
CFQ        19.062      15.251      22.127      2.1197      1.0032       1.376

CSCAN   14.553      22.108      14.72       2.394       0.9304         1.399


The machine configuation is as follows
CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz
Memory: 1027500 KB (1 GB)
Filesystem: ext3
Kernel:   2.6.16.2

If interseted you may have a look at the raw data at
http://www.google.com/notebook/public/14554179817860061151/BDQtXSwoQ2_mdxLgh

- Vishal
