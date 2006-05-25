Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbWEYMEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbWEYMEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 08:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbWEYMEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 08:04:44 -0400
Received: from ns.mipt.ru ([193.125.143.173]:37848 "EHLO mail.telecom.mipt.ru")
	by vger.kernel.org with ESMTP id S965125AbWEYMEo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 08:04:44 -0400
Message-ID: <44758D79.3020302@sw.ru>
Date: Thu, 25 May 2006 14:56:57 +0400
From: Vasily Tarasov <vtaras@sw.ru>
Reply-To: vtaras@sw.ru
Organization: SWSoft
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de
CC: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>
Subject: ioprio feature behaviour
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I produced a little test of ioprio feature. Results are basically good 
enough,
but there is something strange on my mind.
The test just runs 8 simple readers with priorities 0, 1, .., 7 in best 
effort class.
Readers read from files and count how much Mbytes per second they can read.
Results are here:
Process # (prio)  Measurement 1  (Mbps)   Measurement 2 (Mbps)    
Measurement 3 (Mbps)
    0                                 6,60                              
            7,37                                 6,19
    1                                 7,87                              
            7,90                                 7,15
    2                                 5,92                               
           4,75                                 4,61
    3                                 3,31                              
            3,34                                 3,4
    4                                 0,95                               
           0,97                                 1,03
    5                                 1,14                              
            1,23                                 1,2
    6                                 0,83                            
              0,96                                 0,83
    7                                 0,41                            
              0,41                                 0,41
( The whole results are at http://www.7ka.mipt.ru/~vass/cfq-tests/tests.pdf)

 The questions are:
1) Why process 0 with priority 0 has less bandwidth than process 1 with 
priority 1?
2) The same with processes (priorities) 4, 5?
3) Why there is no _uniform_ dependence between bandwidth and priority?
4) Why sums of bandwidths of processes when priorities are setted and 
when they are not setted (look in pdf) aren't equal?

Thanks, Vasily.
