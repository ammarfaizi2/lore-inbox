Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSHYM3Z>; Sun, 25 Aug 2002 08:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317341AbSHYM3Z>; Sun, 25 Aug 2002 08:29:25 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:31961 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S317329AbSHYM3Y>; Sun, 25 Aug 2002 08:29:24 -0400
Message-ID: <20020825123334.460.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <riel@conectiva.com.br>
Cc: conman@kolivas.net, <linux-kernel@vger.kernel.org>
Date: Sun, 25 Aug 2002 20:33:34 +0800
Subject: Re: Combined performance patches update for 2.4.19
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rik van Riel <riel@conectiva.com.br>

[...]
> > Maybe I can find the time to run a few tests, can anyone suggest me an
> > "intersting" test?
> 
> Bob Matthews has a benchmark called irman, which tries to measure
> response time during a number of background loads.
> 
> I'm not sure it is too interesting in this case, though. People
> don't really care about the exact latency of sub-millisecond
> responses (should be the vast majority) but about the few times
> per minute where their mp3 skips.
> 
> Simple averages won't show the mp3 skips, because the number of
> fast responses are bound to be hundreds of thousands of times
> more common then the "mp3 skipping hickups".
> 
> Maybe the histogram mode of irman might show something useful ?
> 
> (then again, maybe it doesn't ... haven't tried yet)
> 
> http://people.redhat.com/bmatthews/irman/
Well... I tried irman, and here it goes the results:

Test: NULL
Kernel                         max       min       avg    stddev
2.4.18                      45.955     0.004     0.005     0.061
2.4.18-0.24pre3              0.121     0.005     0.005     0.001
2.4.19                       1.683     0.005     0.005     0.002
2.4.19-ck3                   1.694     0.005     0.005     0.002
2.4.19-ck3-aa                0.200     0.005     0.005     0.001
2.4.19-ck3-rmap              1.628     0.005     0.005     0.002
2.5.31                       1.636     0.006     0.007     0.002

Test: MEMORY
Kernel                         max       min       avg    stddev
2.4.18                      69.471     0.005     0.010     0.554
2.4.18-0.24pre3             70.031     0.005     0.010     0.546
2.4.19                      60.058     0.005     0.011     0.558
2.4.19-ck3                 150.216     0.005     0.009     0.720
2.4.19-ck3-aa              150.075     0.005     0.008     0.621
2.4.19-ck3-rmap            150.059     0.005     0.009     0.674
2.5.31                       1.823     0.005     0.007     0.002

Test: FILE_IO
Kernel                         max       min       avg    stddev
2.4.18                     190.042     0.005     0.019     1.452
2.4.18-0.24pre3            325.509     0.005     0.017     1.379
2.4.19                     190.033     0.005     0.022     1.525
2.4.19-ck3                1050.048     0.005     0.015     2.196
2.4.19-ck3-aa             1363.153     0.005     0.014     2.177
2.4.19-ck3-rmap            450.073     0.005     0.016     2.097
2.5.31                     610.021     0.006     0.019     2.314

Test: PROCESS
Kernel                         max       min       avg    stddev
2.4.18                     350.056     0.005     0.068     2.548
2.4.18-0.24pre3            270.138     0.005     0.068     2.439
2.4.19                     270.238     0.005     0.075     2.594
2.4.19-ck3                1710.017     0.005     0.022     4.293
2.4.19-ck3-aa             1620.023     0.005     0.023     4.298
2.4.19-ck3-rmap           1630.020     0.005     0.025     4.724
2.5.31                    1171.021     0.006     0.026     4.354

Ciao,
              Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
