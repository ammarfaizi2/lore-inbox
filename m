Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbUAVOFp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 09:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266019AbUAVOFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 09:05:45 -0500
Received: from hell.org.pl ([212.244.218.42]:2063 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S264507AbUAVOFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 09:05:44 -0500
Date: Thu, 22 Jan 2004 15:05:46 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: "Georg C. F. Greve" <greve@gnu.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Martin Loschwitz <madkiss@madkiss.org>, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
Message-ID: <20040122140546.GD5194@hell.org.pl>
Mail-Followup-To: Mikael Pettersson <mikpe@csd.uu.se>,
	"Georg C. F. Greve" <greve@gnu.org>,
	"Nakajima, Jun" <jun.nakajima@intel.com>,
	Martin Loschwitz <madkiss@madkiss.org>,
	linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
	acpi-devel@lists.sourceforge.net
References: <7F740D512C7C1046AB53446D3720017361885C@scsmsx402.sc.intel.com> <m3u12pgfpr.fsf@reason.gnu-hamburg> <m3ptddgckg.fsf@reason.gnu-hamburg> <20040122120854.GB3534@hell.org.pl> <16399.55109.244040.516731@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <16399.55109.244040.516731@alkaid.it.uu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Mikael Pettersson:
>  > diff -Bru linux-2.6.0-test8/arch/i386/kernel/apic.c patched/arch/i386/kernel/apic.c
>  > --- linux-2.6.0-test8/arch/i386/kernel/apic.c	2003-10-18 05:43:36.000000000 +0800
>  > +++ patched/arch/i386/kernel/apic.c	2003-10-30 23:17:50.000000000 +0800
>  > @@ -836,8 +836,8 @@
>  >  {
>  >  	unsigned int lvtt1_value, tmp_value;
>  >  
>  > -	lvtt1_value = SET_APIC_TIMER_BASE(APIC_TIMER_BASE_DIV) |
>  > -			APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
>  > +	lvtt1_value = APIC_LVT_TIMER_PERIODIC | LOCAL_TIMER_VECTOR;
>  > +
>  >  	apic_write_around(APIC_LVTT, lvtt1_value);
> 
> What is the purpose of this change?
> I don't remember seeing this before on LKML. (I don't have time to read bugzilla.)

I don't really know. I'm not the author of the patch, I just found it on my
disk and I remember it allowed me to boot with LAPIC compiled in, as the
system would otherwise hang during _STA and _INI execution. I don't even
know if the patch is still correct.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
