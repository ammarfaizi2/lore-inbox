Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130768AbRDSQJK>; Thu, 19 Apr 2001 12:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131205AbRDSQJA>; Thu, 19 Apr 2001 12:09:00 -0400
Received: from user-vc8ftn3.biz.mindspring.com ([216.135.246.227]:63244 "EHLO
	mail.ivivity.com") by vger.kernel.org with ESMTP id <S130768AbRDSQIu>;
	Thu, 19 Apr 2001 12:08:50 -0400
Message-ID: <25369470B6F0D41194820002B328BDD27C91@ATLOPS>
From: Marc Karasek <marc_karasek@ivivity.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: FW: Bug in serial.c 
Date: Thu, 19 Apr 2001 12:08:42 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

-----Original Message-----
From: Marc Karasek
To: 'Richard B. Johnson '
Sent: 4/19/01 11:53 AM
Subject: RE: Bug in serial.c 

 Did something change between 2.4.2 & 2.4.3? Under 2.4.2 I did not have
to init the terminal (are you refering to the host or client side?) and
just accepted the defaults (9600, 8n1) which was fine for debug and
terminal I/O.  

My issue is with 2.4.2 it works with 2.4.3 (same .config) it does not.
So in my mind this is a bug of some type.....  :-) 

Which kernel are you using in your embedded project??




-----Original Message-----
From: Richard B. Johnson
To: Marc Karasek
Cc: 'linux-kernel@vger.kernel.org'
Sent: 4/19/01 11:43 AM
Subject: Re: Bug in serial.c 

On Thu, 19 Apr 2001, Marc Karasek wrote:

> I am doing some embedded development with the 2.4.x series and have
noticed
> a few things..
>
[SNIPPED...]
 
> 
> 2) In 2.4.3 the console port using ttySX is broken.  It dumps fine to
the
> terminal but when you get to a point of entering data (login,
configuration
> scripts, etc) the terminal does not accept any input.  
>

It is not broken. It is used all the while in our embeded systems.
 
> So far I have been able to debug to the point where I see that the
kernel is
> receiving the characters from the serial.c driver.  But it never echos
them
> or does anything else with them.  I will continue to look into this at
this
> end.  
> 

Did you ever initialize the terminal? And I'm not talking about
baud-rate.
There is a termios structure of information necessary to configure a
terminal for I/O.

> I was also wondering if anyone else has seen this or if a patch is
avail for
> this bug??

You refer to a BUG?  There isn't any of the kind you describe.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.

