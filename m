Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265201AbRF0Gfc>; Wed, 27 Jun 2001 02:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbRF0GfX>; Wed, 27 Jun 2001 02:35:23 -0400
Received: from nw171.netaddress.usa.net ([204.68.24.71]:29880 "HELO
	nw171.netaddress.usa.net") by vger.kernel.org with SMTP
	id <S265201AbRF0GfP> convert rfc822-to-8bit; Wed, 27 Jun 2001 02:35:15 -0400
Message-ID: <20010627063513.18205.qmail@nw171.netaddress.usa.net>
Date: 27 Jun 2001 00:35:13 MDT
From: Blesson Paul <blessonpaul@usa.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [Re: Process creating]
X-Mailer: USANET web-mailer (34FM.0700.17C.01)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Android
                        IPC is my last resort. The reason is that, my present
project is to convert a present software to run in beowlf. I am using Mosix
which enables me to parralize the software through forking. The present
software is highly data oriented and highly  complicated. If all the processes
manipulates the data in the same memory area, I need not look into IPC.
Moreover there is less need for synchronisation since the data are readonly.
The memory mapping in  different systems are done by Mosix. It somehow enables
me to use all the memory in different systems as if they are of single one    
      
                             by
                                   Blesson
 
Android <android@abac.com> wrote:

>1  If I point  to a address 0x434343 in P1 and  P2, will it point to the
>same memory area.
>2  If not, I need two processes to use same process area, how to do that
>3  Will linux kernel support threading
>                             Actually I first thought about shared memory.
But
>for my application, I need huge memory area upto 50MB or more. So 50MB of
>shared memory is no good. So I looking for any other alternatives
>
>                        by
>                                   Blesson

1: P1 and P2 have different physical areas of memory. This is how 
protection works.

2: Why do they need to share the same memory? You can have your second
process
communicate with your first process through IPC.

3: Linux supports threading if you include the thread library, and use the 
appropriate
threading process calls.

Another thing you can do is have a common space on the hard drive. It's not 
as fast as RAM,
but it's one solution.

                                                        -- Ted



