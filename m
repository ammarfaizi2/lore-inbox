Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289547AbSAOMob>; Tue, 15 Jan 2002 07:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289545AbSAOMoM>; Tue, 15 Jan 2002 07:44:12 -0500
Received: from dlezb.ext.ti.com ([192.91.75.132]:46578 "EHLO go4.ext.ti.com")
	by vger.kernel.org with ESMTP id <S289541AbSAOMoG>;
	Tue, 15 Jan 2002 07:44:06 -0500
Message-ID: <3C44240F.6070202@ti.com>
Date: Tue, 15 Jan 2002 13:43:59 +0100
From: christian e <cej@ti.com>
Organization: Texas Instruments A/S,Denmark
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011202
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Swap: an update on how my box is running now..
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,all

Yesterday I downloaded 2.4.18pre2 patch and the 2.4.18pre2-aa2 patch.

Then did the echo 500 > /proc/sys/vm/vm_mapped_ratio

as François recommended..

So far looking good..Not nearly as swap happy now..Here's top output:

foo@bar:~$ top -bn 1|head -n 15


  13:40:21 up  3:19,  5 users,  load average: 0.57, 0.65, 0.70
113 processes: 108 sleeping, 5 running, 0 zombie, 0 stopped
CPU states:  11.6% user,  15.7% system,   0.0% nice,  72.6% idle
Mem:    514148K total,   508664K used,     5484K free,     9140K buffers
Swap:   248968K total,     8424K used,   240544K free,   281180K cached

   PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
  2056 ce        17   0  1020 1016   772 R    13.5  0.1   0:00 top
  1596 ce         1   0  210M 210M  210M R    12.7 41.9  27:23 vmware
  1599 ce        20 -19 99972  97M 99380 S <   0.8 19.3   0:12 vmware
     1 root      20   0   524  524   460 S     0.0  0.1   0:04 init
     2 root      20   0     0    0     0 SW    0.0  0.0   0:00 keventd
     3 root      20   0     0    0     0 SW    0.0  0.0   0:00 kapm-idled


Still I'm wondering why 'cached' is soo big.Can I tune it so that it 
wont swap until cache+buffers are close to 0 ???
But anyway..I can finally use my Windows in Vmware..Great..

best regards

Christian

