Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274014AbRIYWXH>; Tue, 25 Sep 2001 18:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273630AbRIYWW5>; Tue, 25 Sep 2001 18:22:57 -0400
Received: from hermes.csd.unb.ca ([131.202.3.20]:4597 "EHLO hermes.csd.unb.ca")
	by vger.kernel.org with ESMTP id <S274014AbRIYWWx>;
	Tue, 25 Sep 2001 18:22:53 -0400
X-WebMail-UserID: newton
Date: Tue, 25 Sep 2001 19:32:41 -0300
From: Chris Newton <newton@unb.ca>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andrew Morton <akpm@zip.com.au>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-EXP32-SerialNo: 00003025, 00003442
Subject: RE: excessive interrupts on network cards
Message-ID: <3BB12DBC@webmail1>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even once I get this current problem worked out, I'd be interested in testing 
something along these lines.  I'm working to build a nice, fast network 
monitor, and so, the performance of the box under high traffic load is very 
important.

  Are these changes totally related to the card you are using, or can they be 
applied more generally to other cards?

Chris

>===== Original Message From Benjamin LaHaise <bcrl@redhat.com> =====
>On Tue, Sep 25, 2001 at 06:38:31PM -0300, Chris Newton wrote:
>> Yea, it is a single port card... I had meant to mention that in the email I
>> sent out...  ie: that it wasn't reporting correctly... but, I didnt really
>> think it was related, since the eepro was doing the same thing.
>>
>>   As for comparing with ifconfig, I ran 'watch 1 ifconfig -a', and sure
>> enough, I have about ~7000-7500 packets coming in right now.  And, the
>> 'procinfo -D', reports ~21000-22000 interrupts per second.
>
>This is heavily dependant on the interrupt mitigation features that a card
>has.  At least for the ns83820 driver, I'm testing a technique where the
>driver essentially switches to polled mode once the interrupt load goes
>above a certain threshold, thereby limiting the load to ~2500 irq/sec.
>Combined with carefully placed data prefetching, I'm seeing a huge increase
>in performance.  Of course, this comes at the expense of latency.
>
>		-ben
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

