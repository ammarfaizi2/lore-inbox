Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262347AbSI1Xyg>; Sat, 28 Sep 2002 19:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262349AbSI1Xyg>; Sat, 28 Sep 2002 19:54:36 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:17867 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S262347AbSI1Xye>;
	Sat, 28 Sep 2002 19:54:34 -0400
Message-ID: <1033257590.3d964276e10e6@kolivas.net>
Date: Sun, 29 Sep 2002 09:59:50 +1000
From: Con Kolivas <conman@kolivas.net>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] 2.5.39 with contest 0.41
References: <20020928151726.18496.qmail@linuxmail.org>
In-Reply-To: <20020928151726.18496.qmail@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paolo Ciarrocchi <ciarrocchi@linuxmail.org>:

> noload:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  133.07          98%             1.00
> 2.4.19                  133.16          98%             1.00
> 2.4.19                  135.43          97%             1.02
> 2.5.38-mm2              138.19          97%             1.04
> 2.5.38-mm2              138.47          96%             1.04
> 2.5.38-mm2              139.54          96%             1.05
> 2.5.39                  138.30          96%             1.04
> 2.5.39                  138.63          96%             1.04
> 2.5.39                  139.99          96%             1.05
> 
> process_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  200.43          60%             1.51
> 2.4.19                  203.11          60%             1.53
> 2.4.19                  203.97          59%             1.53
> 2.5.38-mm2              194.42          69%             1.46
> 2.5.38-mm2              195.19          69%             1.47
> 2.5.38-mm2              207.36          64%             1.56
> 2.5.39                  190.44          70%             1.43
> 2.5.39                  191.37          70%             1.44
> 2.5.39                  193.60          69%             1.45
> 
> io_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  486.58          27%             3.66
> 2.4.19                  593.72          22%             4.46
> 2.4.19                  637.61          21%             4.79
> 2.5.38-mm2              232.35          61%             1.75
> 2.5.38-mm2              237.83          57%             1.79
> 2.5.38-mm2              274.39          50%             2.06
> 2.5.39                  242.98          57%             1.83
> 2.5.39                  294.52          50%             2.21
> 2.5.39                  328.01          42%             2.46
> 
> mem_load:
> Kernel                  Time            CPU             Ratio
> 2.4.19                  172.24          78%             1.29
> 2.4.19                  174.74          77%             1.31
> 2.4.19                  174.87          77%             1.31
> 2.5.38-mm2              165.53          82%             1.24
> 2.5.38-mm2              170.00          80%             1.28
> 2.5.38-mm2              171.96          79%             1.29
> 2.5.39                  167.92          81%             1.26
> 2.5.39                  170.80          80%             1.28
> 2.5.39                  172.68          79%             1.30

Quick statistical analysis:
Noload, 2.5.39 is slower than 2.4.19 and same as 2.5.38-mm2

ProcessLoad, 2.5.39 is slower than 2.4.19 and same as 2.5.38-mm2

IO Load, 2.5.39 is faster than 2.4.19 and _appears_ slower than 2.5.38-mm2 but
has no statistically significant difference; This is probably a type 2 error
(meaning more samples are required). Paolo if you could perform three more runs
on these two kernels it would help discriminate for those in the crowd who need
firm proof.

Mem Load, 2.5.39 is faster than 2.4.19 and same as 2.5.38-mm2


Note that for the results to be useful, they need to be run back to back on the
same system as you seem to have done. If you use your machine between runs for
something else, it can and probably will affect any further results.

Con
