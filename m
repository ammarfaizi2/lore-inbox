Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292385AbSCUFVD>; Thu, 21 Mar 2002 00:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293035AbSCUFUx>; Thu, 21 Mar 2002 00:20:53 -0500
Received: from web10108.mail.yahoo.com ([216.136.130.58]:21520 "HELO
	web10108.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292385AbSCUFUk>; Thu, 21 Mar 2002 00:20:40 -0500
Message-ID: <20020321052039.11197.qmail@web10108.mail.yahoo.com>
Date: Wed, 20 Mar 2002 21:20:39 -0800 (PST)
From: Ivan Gurdiev <ivangurdiev@yahoo.com>
Subject: Re: Via-Rhine stalls - transmit errors
To: Andy Carlson <naclos@andyc.dyndns.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is a patch the Urban Widmark originally came up
> with for 2.4.17, 
> and I retrofitted to 2.4.18.  I do not know if it 
> will patch vs 2.4.19-pre3:

It does. However the problem persists.
I changed the default debug value to 7 again.

Here's more information:
Unlike the old driver this one repeatedly logs:
Mar 20 21:47:50 cobra kernel: eth0: Setting
full-duplex based on MII #1 link partner capability of
3100. 
Mar 20 21:48:30 cobra last message repeated 4 times

...when inactive...

The opposite side repeatedly logs:
eth0: lost link beat
eth0: found link beat
eth0: autonegotiation complete: 100BaseT-FD selected

As for the scp transfer.... same problem except 
now I get "Transmitter underflow?" errors
and status of 0008.

Here's a section of an example log:
--------------------------------------------------
Mar 20 21:51:51 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 20 21:51:51 cobra kernel: eth0: Transmitter
underflow?, status 001a.
Mar 20 21:51:51 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshol                      
        d setting to 60.
Mar 20 21:51:51 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 20 21:51:52 cobra kernel: eth0: Transmitter
underflow?, status 0008.
Mar 20 21:51:52 cobra kernel: eth0: Something Wicked
happened! 0008.
Mar 20 21:51:56 cobra kernel: NETDEV WATCHDOG: eth0:
transmit timed out
Mar 20 21:51:56 cobra kernel: eth0: Transmit timed
out, status 0000, PHY status                          
     782d, resetting...
Mar 20 21:51:56 cobra kernel: eth0: reset finished
after 5 microseconds.
Mar 20 21:51:56 cobra kernel: eth0: Setting
full-duplex based on MII #1 link par                  
            tner capability of 3100.
Mar 20 21:51:59 cobra kernel: eth0: Transmitter
underflow?, status 001a.
Mar 20 21:51:59 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshol                      
        d setting to 40.
Mar 20 21:51:59 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 20 21:51:59 cobra kernel: eth0: Transmitter
underflow?, status 000a.
Mar 20 21:51:59 cobra kernel: eth0: Something Wicked
happened! 000a.
Mar 20 21:51:59 cobra kernel: eth0: Transmitter
underflow?, status 0008.
Mar 20 21:51:59 cobra kernel: eth0: Something Wicked
happened! 0008.
Mar 20 21:51:59 cobra kernel: eth0: Transmitter
underflow?, status 001a.
Mar 20 21:51:59 cobra kernel: eth0: Transmitter
underrun, increasing Tx threshol                      
        d setting to 60.
Mar 20 21:51:59 cobra kernel: eth0: Something Wicked
happened! 001a.
Mar 20 21:52:00 cobra kernel: eth0: Transmitter
underflow?, status 0008.
Mar 20 21:52:00 cobra kernel: eth0: Something Wicked
happened! 0008.
Mar 20 21:52:00 cobra kernel: eth0: Transmitter
underflow?, status 0008.
Mar 20 21:52:00 cobra kernel: eth0: Something Wicked
happened! 0008.
Mar 20 21:52:00 cobra kernel: eth0: Transmitter
underflow?, status 0008.
Mar 20 21:52:00 cobra kernel: eth0: Something Wicked
happened! 0008.
Mar 20 21:52:00 cobra kernel: eth0: Setting
full-duplex based on MII #1 link par                  
            tner capability of 3100.

------------------------
Let me know how I can help.
Thanks for your assistance.



__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
