Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292836AbSCOQCb>; Fri, 15 Mar 2002 11:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292837AbSCOQCW>; Fri, 15 Mar 2002 11:02:22 -0500
Received: from ns1.advfn.com ([212.161.99.144]:53264 "EHLO mail.advfn.com")
	by vger.kernel.org with ESMTP id <S292836AbSCOQCK>;
	Fri, 15 Mar 2002 11:02:10 -0500
Message-Id: <200203151602.g2FG27s10703@mail.advfn.com>
Content-Type: text/plain; charset=US-ASCII
From: Tim Kay <timk@advfn.com>
Reply-To: timk@advfn.com
Organization: Advfn.com
To: dmarkh@cfl.rr.com
Subject: Re: Advanced Programmable Interrupt Controller (APIC)?
Date: Fri, 15 Mar 2002 16:03:46 +0000
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C91DC2D.BBEF50F6@cfl.rr.com>
In-Reply-To: <3C91DC2D.BBEF50F6@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark,
	we have a similar problem using PowerEdge 2450s 1550s and 6400s, all our 
machines are running with noapic in the lilo config which sounds like it 
isn't an option for you. I'd be interested where you heard about Dell 
stuffing up the setup of the APIC chip because we may be able to take this up 
with them. I've had no reply from the list for the message below (maybe it 
would be better posted to Kernel Traffic SMP but that's a very quiet list). 
Anyway maybe the BSD diagnostics will help you investigate this.

--------------------enc---------------
Hello,
just a quickie, our Dell Poweredge boxes - Serverworks motherboard - are 
continually pumping out IO-APIC errors as I've reported here before, we have 
three of the same boxes running FreeBSD (limitless file descriptors per 
process - sorry, we need it!) and I've just noticed that dmesg on these says 
that:

IO APIC - APIC_IO: Testing 8254 interrupt delivery
APIC_IO: Broken MP table detected: 8254 is not connected to IOAPIC #0 intpin 
2 
APIC_IO: routing 8254 via 8259 and IOAPIC #0 intpin 0 

Does this help anyone diagnose the error??

/-------------------enc------------------



On Friday 15 Mar 2002 11:34, Mark Hounschell wrote:
> We have a number of DELL boxes in house. The most recent a 6400 (quad p4
> box). Also a couple of dual boxes. They all lock up intermittantly when
> APIC is enabled. There seems to be no solid way of reproducing the hangs
> they just hang randomly. With APIC disabled they do not.
> The app that we have to run on these boxes requires that APIC is enabled
> for irq affinity. It is a soft real-time app that cannot tollerate the
> jitter. It will run but interrupt latency is unexceptable without the irq
> affinity set. I've read on many lists that if you have random lockups that
> you should disableapic. I've also got a number of NON-DELL boxes that don't
> exibit this lockup. Now I've also heard that DELL does not properly setup
> the APIC chip in
> the bios because MS os's don't use it. Have no idea if this is true or not.
> We are using vanilla kernels (2.4.16) with some process affinity patches
> applied. I've also noticed that on the quad boxes (6400) that irqs 0,1,2
> cannot be directed to or from a particular processor. This is also a
> problem with our app. Mostly it's the lockups that occur with APIC enabled
> that is our roadblock for using these nice DELL boxes for our app. Can
> anyone shed some light on this.
>
> Thanks in advance
> and regards

-- 
----------------
Tim Kay
systems administrator
Advfn.com Plc - http://www.advfn.com/
timk@advfn.com
Tel: 020 7070 0941
Fax: 020 7070 0959
