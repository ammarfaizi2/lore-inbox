Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWKBOro@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWKBOro (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWKBOro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:47:44 -0500
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:45958 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1751049AbWKBOrn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:47:43 -0500
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: fc6 kernel 2.6.18-1.2798 breaks acpi on HP laptop n5430
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Stephen.Clark@seclark.us
Cc: Dave Jones <davej@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <454A0352.8010207@seclark.us>
References: <4548DDF4.2030903@seclark.us>
	 <20061101201218.GA4899@martell.zuzino.mipt.ru>
	 <45490EFE.1060608@seclark.us> <20061101235546.GB10577@redhat.com>
	 <4549450F.3080207@seclark.us>  <20061102030353.GA2797@redhat.com>
	 <1162441409.7677.23.camel@monteirov>  <454A0352.8010207@seclark.us>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 14:47:40 +0000
Message-Id: <1162478860.12936.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-02 at 09:40 -0500, Stephen Clark wrote:
> Sergio Monteiro Basto wrote:
> 
> >On Wed, 2006-11-01 at 22:03 -0500, Dave Jones wrote:
> >  
> >
> >>On Wed, Nov 01, 2006 at 08:08:31PM -0500, Stephen Clark wrote:
> >>
> >> > booting without lapic allowed it to boot but now I get
> >> > ...
> >> > Local APIC disabled by BIOS -- you can enable it with "lapic"
> >> > ...
> >> > Local APIC not detected. Using dummy APIC emulation.
> >> >   which means more processor overhead - right?
> >> > 
> >> > also cpuspeed doesn't work anymore - I don't have a cpufreq dir
> >>
> >>The Duron had powernow ?
> >>    
> >>
> >
> >This story of trying enable lapic when BIOS don't, has been triggered on
> >kernel2.6.18, but in my opinion is not a bug if lapic on those computers
> >don't work.
> >
> >If you boot without enable lapic, you will see cat /proc/interrupts with
> >interrupts in XT-PIC.
> >if you try enable lapic, somehow IRQ routing should change 
> >and if /proc/interrupts still the same, with IRQs in XT-PIC.
> >I think, lapic still not enabled and the most you can get it's problems.
> >Unless you know that lapic works (it is programmed and BIOS wrongly
> >disable it), you shouldn't try enable lapic because it is probable that
> >just give problems, to you. 
> >Historically: In 2002/3 was a very common bug, when kernel was compiled
> >to support lapic and try enable lapic (even when BIOS don't) and
> >computer hangs on boot. 
> >  
> >
> Loading the correct kernel arch 686 - fixes my powernow problems - this 
> is a mobile duron.
> 
> Booting with lapic worked fine on  fc5 kernel-2.6.18-2200 but it causes 
> fc6 kernel-2.6.18-2798
> to hang.

With lapic boot option enabled, have you a different /proc/interrupts ? 
have you lapic working ? 


