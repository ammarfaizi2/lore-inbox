Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133106AbRDLPb2>; Thu, 12 Apr 2001 11:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133109AbRDLPbS>; Thu, 12 Apr 2001 11:31:18 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:40525 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S133106AbRDLPbC>; Thu, 12 Apr 2001 11:31:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marcin Kowalski <kowalski@datrix.co.za>
Reply-To: kowalski@datrix.co.za
Organization: Datrix Solutions
To: tomlins@cam.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: memory usage - dentry_cacheg
Date: Thu, 12 Apr 2001 17:30:59 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.GSO.4.21.0104120110210.18135-100000@weyl.math.psu.edu> <20010412114617.051FE723C@oscar.casa.dyndns.org>
In-Reply-To: <20010412114617.051FE723C@oscar.casa.dyndns.org>
MIME-Version: 1.0
Message-Id: <0104121730590X.11986@webman>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have applied this(Tom's) patch as well as the small change to 
dcache.c(thanx Andreas, David, Alexander and All), I ran some tests and so 
far so good, both the dcache and inode cache entries in slabinfo are keeping 
nice and low even though I tested by creating thousands of files and then 
deleting then. The dentry and icache both pruged succesfully.

Under the high memory usage test 350 mb of swap was left behind after the 
process terminated leaving 750mb of free memory(physical). Why is this??
I did a swapoff which brough the machine to its' knees for the better part of 
2 minutes  and then a swapon and I was left with 170 megs used memory in 
total... I must say that I find it odd that the swap is not cleared if there 
is avaialbe "real" memory. 

Anyway time will tell, I shall see how it performs over the long weekend. 
HOpefully no *crashes*, Thanks to all concerned for their help... I learned 
*lots*.

Regards
MarCin


-----------------------------
     Marcin Kowalski
     Linux/Perl Developer
     Datrix Solutions
     Cel. 082-400-7603
      ***Open Source Kicks Ass***
-----------------------------
