Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbWESLnw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbWESLnw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 07:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbWESLnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 07:43:52 -0400
Received: from spirit.analogic.com ([204.178.40.4]:23309 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932285AbWESLnu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 07:43:50 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 19 May 2006 11:43:48.0204 (UTC) FILETIME=[7DE352C0:01C67B39]
Content-class: urn:content-classes:message
Subject: Re: Stealing ur megahurts (no, really)
Date: Fri, 19 May 2006 07:43:47 -0400
Message-ID: <Pine.LNX.4.61.0605190740090.13794@chaos.analogic.com>
In-Reply-To: <20060519112218.GE19673@gallifrey>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Stealing ur megahurts (no, really)
Thread-Index: AcZ7OX3siyelW13VTQW8P3HD2bNSSg==
References: <446D61EE.4010900@comcast.net> <20060519112218.GE19673@gallifrey>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: <linux-kernel@vger.kernel.org>,
       "John Richard Moser" <nigelenki@comcast.net>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 May 2006, Dr. David Alan Gilbert wrote:

> * John Richard Moser (nigelenki@comcast.net) wrote:
>
>> Scrambling for an old machine is ridiculous.  Down-clocking makes sense
>> because you can adjust to varied levels; but it's difficult and usually
>> infeasible.  Pulling memory and mix and matching is not much better.
>
> <...>
>
>> This brings the idea of a cpumhz= parameter to adjust CPU clock rate.
>> Obviously we can't do this directly, as convenient as this would be; but
>> the idea warrants some thought, and some thought I gave it.  What I came
>> up with was simple:  Adjust time slice length and place a delay between
>> time slices so they're evenly spaced.
>
> <...>
>
> Hi John,
>  While cpu downclocking helps a bit, it would be hopelessly inaccurate
> for figuring out if your app would run fast enough on the given
> ancient machine.  A lot else has happened to the world since the days
> of the 200MHz CPU:
>    * Faster memory
>    * Larger caches
>    * Faster PCI busses
>    * Instruction set additions (various more levels of SSE etc)
>    * Faster discs
>    * Changes to the CPU architecture/implementation
>
> Still, it would be interesting to see the difference in performance
> of a downclocked modern processor and its 10 year old clock equivalent.
>
> Dave
>
> --
> -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \
> \ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
> \ _________________________|_____ http://www.treblig.org   |_______/
> -

You can readily slow down a machine by creating a bunch of tasks
that just do:

int main() {
 	for(;;)
           ;
}

They will use their entire time-slice until preempted. You want
it slower, create more such tasks. FYI, `top` should show them
all getting the same amount of CPU time. If they don't the
scheduler is broken!

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
