Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131477AbRC0SY2>; Tue, 27 Mar 2001 13:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbRC0SYT>; Tue, 27 Mar 2001 13:24:19 -0500
Received: from f48.law14.hotmail.com ([64.4.21.48]:12813 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S131477AbRC0SYD>;
	Tue, 27 Mar 2001 13:24:03 -0500
X-Originating-IP: [12.44.186.158]
From: "Dinesh Nagpure" <fatbrrain@hotmail.com>
To: moz@compsoc.man.ac.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: hooking APIC timer doesnt work?
Date: Tue, 27 Mar 2001 10:23:17 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F48fzDskqC5EtrUVYKk00000d10@hotmail.com>
X-OriginalArrivalTime: 27 Mar 2001 18:23:17.0316 (UTC) FILETIME=[FE675040:01C0B6EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John,

First of all let me thank you for pointing to Vincent Oberle's APIC timer 
module, I am trying to understand  how the timer is hooked in it. BTW 
forgive my ignorance but what is oprofile? the reason I am trying to hook 
perfctr is, well let me tell you what I am trying to do here, I want to 
measure time spent between a cli and the corresponding sti, I am using the 
performance monitoring event CYCLES_INT_MASKED and setting the perfctr MSR 
to overflow on the first cycle after a cli, this overflow will generate 
PCINT from the APIC which I am programming in delivery mode NMI, here I will 
take my initial TSC reading, and also program the APIC timer initial count 
register to to trigger on the next clock, but this timer interrupt will be 
kept pending as long as the interrupts are disabled in the system, and will 
get serviced after a sti occurs, here I take my second TSC reading,
any comments?

Dinesh

----Original Message Follows----
From: John Levon <moz@compsoc.man.ac.uk>
To: Dinesh Nagpure <fatbrrain@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: hooking APIC timer doesnt work?
Date: Tue, 27 Mar 2001 12:38:01 +0100 (BST)

On Mon, 26 Mar 2001, Dinesh Nagpure wrote:

 > Hello all,
 > I am trying to use the LAPIC timer to generate interrupt for some kernel
 > profiling work I am doing...but the timer ISR isnt invoking atall....here 
is
 > what I have done....
 >

Have you seen Vincent Oberle's APIC timers module ? There is a link at 
kernelnewbies.org

Also, what are you doing with the perfctr interrupt ? Are you aware of 
perfctr and oprofile ?

john

--
"Stop telling God what to do."
	- Niels Bohr


_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

