Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262314AbSLLKYA>; Thu, 12 Dec 2002 05:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSLLKYA>; Thu, 12 Dec 2002 05:24:00 -0500
Received: from elin.scali.no ([62.70.89.10]:7946 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S262314AbSLLKX7>;
	Thu, 12 Dec 2002 05:23:59 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Terje Eggestad <terje.eggestad@scali.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
In-Reply-To: <1039687609.1450.2.camel@laptop.fenrus.com>
References: <1039610907.25187.190.camel@pc-16.office.scali.no>
	 <3DF78911.5090107@zytor.com>
	 <1039686176.25186.195.camel@pc-16.office.scali.no>
	 <1039687609.1450.2.camel@laptop.fenrus.com>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1039689102.25186.201.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 12 Dec 2002 11:31:42 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On tor, 2002-12-12 at 11:06, Arjan van de Ven wrote:
> On Thu, 2002-12-12 at 10:42, Terje Eggestad wrote:
> 
> > It takes about 11 cycles on athlon, 34 on PII, and a whooping 84 on P4.
> > 
> > For a simple op like that, even 11 is a lot... Really makes you wonder.
> 
> wasn't rdtsc also supposed to be a pipeline sync of the cpu?
> (or am I confusing it with cpuid)

THis is what the P4 manual says:

"The RDTSC instruction is not a serializing instruction. Thus, it does
not necessarily wait until all previous instructions have been executed
before reading the counter. Similarly, subsequent instructions may begin
execution before the read operation is performed."

Thus it *shouldn't* sync the pipeline. cpuid is a serializing inst, yes.

TJ

-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

