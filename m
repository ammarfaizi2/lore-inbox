Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293135AbSEAKCo>; Wed, 1 May 2002 06:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293337AbSEAKCn>; Wed, 1 May 2002 06:02:43 -0400
Received: from smtp1.libero.it ([193.70.192.51]:37512 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S293135AbSEAKCm> convert rfc822-to-8bit;
	Wed, 1 May 2002 06:02:42 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Andrea Aime <aaime@libero.it>
To: linux-kernel@vger.kernel.org
Subject: How to tune vm to be less swap happy?
Date: Wed, 1 May 2002 12:02:38 +0000
User-Agent: KMail/1.4.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200205011202.38653.aaime@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody,
sorry to bother you with this question, but I feel that current vm defaults 
are not tuned for a workstation use, but for a file server/db server use.
I work on a couple of machines with 128MB of RAM, tipically use KDE 3.0
and Netbeans (a Java IDE). Ok, I use bloated software, I should have more
RAM. Fine. But what I don't understand is why the system keeps swapping
data in and out just because it doesn't want to shrink the cache below 40 MB.
My typical memory occupation is:

             total       used       free     shared    buffers     cached
Mem:        127096     123264       3832          0       1216      48164
-/+ buffers/cache:      73884      53212
Swap:       257000      62316     194684

Now, as you can see I would need 135 MB to keep all my programs in memory,
and if you look at top output:

 PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME COMMAND
 4397 wolf       9   0 79196  71M 30472 S     0,0 57,4   0:00 java
 4398 wolf       8   0 79196  71M 30472 S     0,0 57,4   0:00 java
...

you'll notice that due to the cache behaviour not even netbeans fits enterely 
in memory. I really doubt that I can benefit from a 48MB disk cache since the 
system is swapping in and out every time I open konqueror, kmail and the 
like... is there anything I can do to shrink the cache and to allow a bigger 
part of my working set to fit into memory? Moreover, what vm tuning do you
advice for a typical workstation use with memory hungry applications?
Best regards
Andrea Aime



