Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129416AbRBWNMg>; Fri, 23 Feb 2001 08:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130437AbRBWNM0>; Fri, 23 Feb 2001 08:12:26 -0500
Received: from [212.115.175.146] ([212.115.175.146]:46074 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S129416AbRBWNMJ>; Fri, 23 Feb 2001 08:12:09 -0500
Message-ID: <27525795B28BD311B28D00500481B7601F0EF4@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>, ahu@ds9a.nl
Subject: Re: random PID generation
Date: Fri, 23 Feb 2001 14:20:27 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I wrote a patch against 2.2.18 and 2.4.1 to have the kernel generate 
>> random PIDs. You can find it at http://vanheusden.com/Linux/security.php3

>> (amongst other patches). Beware: pretty much experimental and likely to 
>> make your linux-pc perform like a win95 platform. 
> Well - I'm not sure that this is a good idea. When PIDs increase 
> monotonically, chances are very small that the race condition implicit in 
> sending any signal to a process results in killing the wrong process (ie,
a 
> new process, but with the same PID) - you'd need to zoom through 32000
PIDs 
> in a very short time to make this happen. 
> With truly random PIDs, there is a much larger chance of a new process 
> sitting on a recently used PID. 

My code runs trough the whole task_list to see if a chosen pid is already
in use or not.

> What would work is to have cryptographically randomly generated PIDs which

> would then guarantee not to return a previously returned number within
32000 
> tries, and also not be predictable - there must be algoritms out there
which 
> do this. 

That's also an option!
But for simplicity-sake, I used the get_random_bytes() function (from
the /dev/random-device) combined with a loop. It's a simplistic hack, but
it'll work for my paranoia mind :o)


Greetings,

Folkert van Heusden
