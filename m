Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277834AbRJIQ6E>; Tue, 9 Oct 2001 12:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277841AbRJIQ5z>; Tue, 9 Oct 2001 12:57:55 -0400
Received: from web14204.mail.yahoo.com ([216.136.172.146]:26119 "HELO
	web14204.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277834AbRJIQ5i>; Tue, 9 Oct 2001 12:57:38 -0400
Message-ID: <20011009165806.80213.qmail@web14204.mail.yahoo.com>
Date: Tue, 9 Oct 2001 09:58:06 -0700 (PDT)
From: java programmer <javadesigner@yahoo.com>
Subject: Re: 2.4.x, smp, eepro100
To: Tyler Longren <tyler@captainjack.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <001e01c14dd0$326264d0$2a23b1cf@win2k>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OS: Slackware 8.0
> Kernel: 2.4.5_nosmp, 2.4.5, and 2.4.10
> NIC: eepro100
> 
> Anyway, installed Slackware with the default scsi
> kernel.  Everything worked
> fine.  I re-compiled 2.4.5 to enable smp support. 
> After re-compiling
> everything is stable until a few hundred megs gets
> uploaded to the box.
> After a few hundred megs get upped to the box
> (through ftp), eth0 just dies.


I too have the *exact* same problem. I am running
slackware 8.0, SMP 2.4.5 kernel on dual PII-Xeon,
2 intel cards with the default eepro100 drivers. 

I even downloaded and tried the intel linux 
drivers (different from the default kernel ones) 
and still had the same problem. The default driver 
*does* give me a "lockup workaround enabled" message
during startup, but after transferring a couple of 
gigs of data, both ethernet cards seem to randomly 
hang up after a couple of days. I even wrote a test
script that constantly ftp'ed files (get/put) and
that worked fine to about 10 Gigs before I got bored
and gave up. A day or two later, the cards hung again.
As far as I can tell, doing google searches on related
keywords, this problem might have something to do
with speed autonegotiation between the cards and
the switch. I am using a Nortel baystack but this
problem seems to also occur with 3com switches. Both
are autonegotiating-only switches with no way 
to manually set the speed of any port. If the problem
continues, I am thinking of getting a pricier intel
switch that does allow for manual port speed setting
to 10 or 100 Mbit/sec. My cards do connect at
100Mbit/s
initially with the current Nortel, so the initial
autonegotiation is OK, but maybe there are subsequent
autonegotiations on a regular basis that fail ?

This problem is quite strange, because a Windows 2000
box, sitting on the same network, showed the same
symptom once. That box was also connected to the
same baystack switch. It may or may not have been
a related problem, it only happened once, while the 
linux problem seems to happen more frequently. And
it really is quite random.

*Once* it happens though, there is no way to 
regain network control of the box - except by
logging in via the console and rebooting the linux 
box. That's kind of a drag, because I am sitting
on the U.S East coast while the box is colocated in
Denver.

Best regards,

javadesigner@yahoo.com




__________________________________________________
Do You Yahoo!?
NEW from Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
