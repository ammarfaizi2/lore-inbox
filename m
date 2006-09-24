Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752062AbWIXCTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbWIXCTi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 22:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbWIXCTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 22:19:38 -0400
Received: from mdmail.ccwis.com ([12.148.212.152]:50444 "EHLO
	computer-connectionsinc.com") by vger.kernel.org with ESMTP
	id S1752062AbWIXCTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 22:19:37 -0400
From: Mark Felder <felderado@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Bug: Asus CUR-DLS and 2.6
Date: Sat, 23 Sep 2006 21:18:20 -0500
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609232118.20410.felderado@gmail.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-RBL-Warning: mail from 64.211.118.1 refused by SpamHaus, see http://www.spamhaus.org
X-MDRemoteIP: 64.211.118.1
X-Return-Path: felderado@gmail.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
X-Spam-Report: *  3.0 MDAEMON_DNSBL MDaemon: marked by MDaemon's DNSBL
	*  1.0 BAYES_40 BODY: Bayesian spam probability is 20 to 40%
	*      [score: 0.3822]
X-Spam-Processed: computer-connectionsinc.com, Sat, 23 Sep 2006 21:14:56 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm writing to report and interesting occurance that I fully believe is a bug 
in the 2.6 kernel. 

In March I purchased a used Asus CUR-DLS motherboard with two socket 370 PIII 
866 processors. I picked up two 256MB PC-133 ECC modules. I proceeded 
installed Linux on it and all was well. I believe my initial kernel was 
approximately 2.6.12.

At the end of May, things went awry. The machine had an interesting issue -- 
it would beep 3 times, and then it would be hardlocked. I didn't have much 
time to test the machine out as it was only a for-fun machine and I had 
started a new job.

Well, I have more free time now, and I've narrowed down the bug I think. 
Here's the situation:

With a 2.6.15 and 2.6.16 kernel on Gentoo I would receive 3 beeps and it would 
hardlock as I expained. The CPU fans shut off -- there's no hope of bringing 
it out of this. Rarely it's happened at GRUB or before GRUB, but only when 
I've been working on this for a long period of time. 

I've tried many live CDs -- most use recent 2.6 kernels, and I could repeat 
nearly the same problem on them. It often occurs when starting networking. 
I've tried onboard e100, tulip, and others that I have access to and I get 
nearly the same results. Depending on the livecd I can either get a hardlock 
+ 3 beeps, or I can receive an address via DHCP, but I can't speak to the 
network at all. The e100 reports "system timing errors" in this occasion. On 
some setups I can reproduce it instantly by having the network cable 
unplugged and plugging it in after it's brought up the e100 interface.

Now I was under the inital impression that I had bad hardware. I've 
thouroughly tested my RAM and even replaced the motherboard with an identical 
ASUS CUR-DLS, so right now I have two of them on my hands, and the one I just 
got has the most recent BIOS, the other did not. The only hardware bug that I 
can see is that one processor incorrectly reports its temperature -- stays 
around 50 celcius all the time, but I figure that's just a bad sensor.

I came to the conclusion it must be a 2.6 bug when I dropped in a Slackware CD 
I just picked up recently. It uses a 2.4 kernel. To my surprise it worked 
fine -- no hardlocks, network works great on all adapters, including onboard. 
Very strange stuff indeed.

Things I've tried with the 2.6 include apic/noapic, nosmp and swapped 
processors to each other's slots, nolapic (dont think it actually works for 
SMP though, I'm not sure on that one), and nearly every combination of them. 
The only other thing I've noticed is that some livecds report an apic but 
when initializing the kernel -- right at the very beginning, and it says to 
report them to the hardware manufacturer and it claims to work around it.

This motherboard uses the Serverworks chipset. I'm not using SCSI.

I would really like to get this bug squashed -- I have a use for this system 
and I'd really really prefer to use a 2.6 kernel. Now since I have an 
identical motherboard on hand, if anyone is interested in figuring out what 
is going on and would like hands on access to the hardware, I could get you 
one of these motherboards. If you really don't have access to PIII's/RAM to 
put in it, I could the whole setup off too, but I'd really like to get it 
back if possible.

I'm open to any suggestions you might have. As of this moment, I'm not on the 
kernel mailing list, but I will be looking to sign up after I send this off. 

Thank you for your time, and keep up the great work everyone :)


Mark Felder

