Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132590AbRDKOvu>; Wed, 11 Apr 2001 10:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132591AbRDKOvl>; Wed, 11 Apr 2001 10:51:41 -0400
Received: from phoenix.datrix.co.za ([196.37.220.5]:29492 "EHLO
	phoenix.datrix.co.za") by vger.kernel.org with ESMTP
	id <S132590AbRDKOvf>; Wed, 11 Apr 2001 10:51:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marcin Kowalski <kowalski@datrix.co.za>
Reply-To: kowalski@datrix.co.za
Organization: Datrix Solutions
To: jjasen1@umbc.edu
Subject: Re: memory usage - continued - iCache/Dentry cacheing bug???
Date: Wed, 11 Apr 2001 16:50:17 +0200
X-Mailer: KMail [version 1.2]
Cc: hahn@coffee.psychology.mcmaster.ca, tomlins@cam.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.31L.02.0104111030180.3516411-100000@irix2.gl.umbc.e>
In-Reply-To: <Pine.SGI.4.31L.02.0104111030180.3516411-100000@irix2.gl.umbc.e>
MIME-Version: 1.0
Message-Id: <0104111650170J.25951@webman>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Further fun...

Now after bouncing the swap and clearing out memory I decided to run the 
test.pl script again to suck up some more memory...
Box dies, pretty much for 15 seconds, when it comes back load is at 8.0
kernel syslog messages..::
----
Apr 11 16:37:13 mkdexii kernel: sym53c896-1-<3,0>: ordered tag forced.
Apr 11 16:37:43 mkdexii last message repeated 2 times
-----
with 181M of Swap in use and 252 mb of Physical RAM.... this is getting 
really tricky...

Now to bounce the swap again.... well well IO lock up again, hmmm. sym53c896 
driver---  load went up to 12 and now I'm left with 135mb of used physical 
ram...

What can I draw from this?? Well memory that is being swapped shouldn't be, 
once it is swapped out it doesn't seem to be reaped(my understanding is 
lacking :-(( ). In my case 250mb of memory was swapped out during my memory 
eater test. The process then died and 750mb of physical ram got freed up but 
still 250mb of swap was in use, I then switched off swap and turned it back 
on and it was gone. WHy was it there in the first place as I had 750mb of 
free physical memory.

Secondly is there a problem with the Sym53c896 driver settings, I upped the 
default queu length to 8 and the Synch Freq to 40mhz????, WHy is the machine 
locking so badly under high IO... ??? 

TIA MARCin


-- 
-----------------------------
     Marcin Kowalski
     Linux/Perl Developer
     Datrix Solutions
     Cel. 082-400-7603
      ***Open Source Kicks Ass***
-----------------------------
