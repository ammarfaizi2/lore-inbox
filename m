Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261529AbSJMQlr>; Sun, 13 Oct 2002 12:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261553AbSJMQlr>; Sun, 13 Oct 2002 12:41:47 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:38545 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S261529AbSJMQlp>; Sun, 13 Oct 2002 12:41:45 -0400
Message-ID: <20021013164731.10615.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Date: Mon, 14 Oct 2002 00:47:31 +0800
Subject: Re:Benchmark results from resp1 trivial response time test
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bill Davidsen <davidsen@tmr.com>
[...]
> run this version I'd like to see the result. I believe I had to use the
> "-l" patch option to ignore blank mismatches to get this to work, and I've
> cleaned up another mailing funny as well. 

Hi Bill,
here the results agains 2.5.41-mm2C (2.5.41-mm2 + Con patch "vmscan.c")

Starting 1 CPU run with 250 MB RAM, minimum 5 data points at 20 sec intervals
 
                       _____________ delay ms. ____________                  
           Test        low       high    median     average     S.D.    ratio
         noload    113.648    114.508    113.707    113.861    0.000    1.000
     smallwrite    116.054    180.420    117.924    130.525    0.028    1.146
     largewrite    114.019    179.770    120.451    134.021    0.028    1.177
        cpuload    106.590    162.893    107.075    118.080    0.025    1.037
      spawnload    106.574    164.898    107.490    118.671    0.026    1.042
       8ctx-mem   7767.843  16917.625   8994.265  10906.788    3.844   95.790
       2ctx-mem   6515.450  18273.101  10344.575  11217.755    4.822   98.521

8ctx-mem and 2ctx-mem show "bad" performance.
Do you think is it possible to apply the patch on the top of 2.5.42-mm2 ?

Ciao,
       Paolo



-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
