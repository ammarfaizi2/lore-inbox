Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136088AbRDVM4n>; Sun, 22 Apr 2001 08:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136089AbRDVM42>; Sun, 22 Apr 2001 08:56:28 -0400
Received: from WARSL401PIP1.highway.telekom.at ([195.3.96.69]:37183 "HELO
	email01.aon.at") by vger.kernel.org with SMTP id <S136088AbRDVM4O>;
	Sun, 22 Apr 2001 08:56:14 -0400
Message-ID: <3AE2D4E7.4D7E58BD@violin.dyndns.org>
Date: Sun, 22 Apr 2001 14:56:07 +0200
From: Hermann Himmelbauer <dusty@violin.dyndns.org>
Reply-To: dusty@strike.wu-wien.ac.at
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Karsten Keil <kkeil@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: APIC-Errors+Crashes on GA 586DX, 2.2.17/2.4.3
In-Reply-To: <E14r6ZO-0004Xf-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > here. These errors itself are not a problem since the APIC bus detect
> > it and recover, but if here are double errors in a way that the checksum
> > is OK, the APIC may run in trouble.
> 
> Also nothing but recent -ac kernels in the 2.4 range handle the replay of
> IPI's sometimes caused by this. That patch is a post 2.4.4 thing to sort out.

Hmmm, that's a little too technical for me ;-)
Does that mean that this patch would perhaps increase the stability of
my board as this code tries to prevent those double errors? 
If yes, where could I get this patch to try it out?

What do you think of the following suggestion:
-Implement two runtime kernel variables like

/proc/sys/kernel/print_apic_errors
This would simply disable those "APIC error" kernel logs, so that the
logfile is not flooded. (45000 log entries in 1 hour are quite a lot).
Anyway once you know that your board has this problem, IMHO there is no
further use in those messages.

/proc/sys/kernel/enable_apic
The second one would enable/disable the APIC code for testing purposes -
like the "noapic" parameter during boottime. But as I have no knowledge
about those kernel internals, perhaps this wish is impossible to
implement...

Once again, thank you for your help!

		Best Regards,
		Hermann

-- 
 ,_,
(O,O)     "There is more to life than increasing its speed."
(   )     -- Gandhi
-"-"--------------------------------------------------------------
