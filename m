Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292952AbSCOR2f>; Fri, 15 Mar 2002 12:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292955AbSCOR20>; Fri, 15 Mar 2002 12:28:26 -0500
Received: from smtp-server3.tampabay.rr.com ([65.32.1.41]:4044 "EHLO
	smtp-server3.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S292952AbSCOR2R>; Fri, 15 Mar 2002 12:28:17 -0500
Message-ID: <3C922F5F.54807AA3@cfl.rr.com>
Date: Fri, 15 Mar 2002 12:29:03 -0500
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Advanced Programmable Interrupt Controller (APIC)?
In-Reply-To: <3C91DC2D.BBEF50F6@cfl.rr.com> <200203151602.g2FG27s10703@mail.advfn.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Kay wrote:
> 
> Mark,
>         we have a similar problem using PowerEdge 2450s 1550s and 6400s, all our
> machines are running with noapic in the lilo config which sounds like it
> isn't an option for you. I'd be interested where you heard about Dell
> stuffing up the setup of the APIC chip because we may be able to take this up
> with them. 

Search the kernel mailing lists at kernel.org for apic and you will find a number
of them. Of coarse this is all hear say.

>I've had no reply from the list for the message below (maybe it
> would be better posted to Kernel Traffic SMP but that's a very quiet list).
> Anyway maybe the BSD diagnostics will help you investigate this.

I have no experience with BSD.

> 
> --------------------enc---------------
> Hello,
> just a quickie, our Dell Poweredge boxes - Serverworks motherboard - are
> continually pumping out IO-APIC errors as I've reported here before, we have
> three of the same boxes running FreeBSD (limitless file descriptors per
> process - sorry, we need it!) and I've just noticed that dmesg on these says
> that:
> 
> IO APIC - APIC_IO: Testing 8254 interrupt delivery
> APIC_IO: Broken MP table detected: 8254 is not connected to IOAPIC #0 intpin
> 2
> APIC_IO: routing 8254 via 8259 and IOAPIC #0 intpin 0
> 
> Does this help anyone diagnose the error??

I see a message very similar but with the text "Broken_Bios". I don't really know
if it is related to the problem or not.

One thing for sure that I can say is that irqs 0,1,2 cannot be directed to or from
any processor on these 6400 boxes. They insist on being stuck to all 4 processors.
This I do beleive is related to the HANGS that I have.

-- 
Mark Hounschell
dmarkh@cfl.rr.com
