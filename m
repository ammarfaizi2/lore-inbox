Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280042AbRKITVj>; Fri, 9 Nov 2001 14:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280043AbRKITV0>; Fri, 9 Nov 2001 14:21:26 -0500
Received: from [192.55.52.18] ([192.55.52.18]:63944 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S280033AbRKITTw>;
	Fri, 9 Nov 2001 14:19:52 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D725@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'george anzinger'" <george@mvista.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jonas Diemer <diemer@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: RE: VIA 686 timer bugfix incomplete
Date: Fri, 9 Nov 2001 11:19:35 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George, I was mistaken before, sorry.

The address of the PM timer is in a table, not in the ACPI namespace. It is
in the FADT. Therefore you should be able to use it iff acpi tables are
present, but it should not strictly require the interpreter.

Regards -- Andy

> -----Original Message-----
> From: george anzinger [mailto:george@mvista.com]
> Sent: Friday, November 09, 2001 9:22 AM
> To: Alan Cox
> Cc: Vojtech Pavlik; Jonas Diemer; linux-kernel@vger.kernel.org
> Subject: Re: VIA 686 timer bugfix incomplete
> Importance: High
> 
> 
> Alan Cox wrote:
> > 
> > > Me thinks the real solution is the ACPI pm timer.  3 times the
> > > resolution of the PIT and you can not stop it.  The 
> high-res-timers
> > > patch will allow you to use this as the time keeper and 
> just use the PIT
> > > to generate interrupts.
> > 
> > For awkward boxes you can use the PIT, for good boxes we 
> can use rdtsc or
> > eventually the ACPI timers when running with ACPI
> 
> I am attempting to use the ACPI timer without waiting for or running
> ACPI.  After all it is there if you can find it.
> 
> George
> 
