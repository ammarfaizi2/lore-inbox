Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274434AbRJaWcS>; Wed, 31 Oct 2001 17:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274752AbRJaWb7>; Wed, 31 Oct 2001 17:31:59 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:39831 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S274434AbRJaWbs>;
	Wed, 31 Oct 2001 17:31:48 -0500
Date: Wed, 31 Oct 2001 22:32:23 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Patrick Mochel <mochel@osdl.org>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: RE: 2xQ: Is PM + ACPI but /no/ APM a valid configuration? Interru 
 pts enabled in APM set power state?
Message-ID: <286406322.1004567543@[195.224.237.69]>
In-Reply-To: <Pine.LNX.4.33.0110311413430.11035-100000@osdlab.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33.0110311413430.11035-100000@osdlab.pdx.osdl.net>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick,

> /proc/apm is created by the APM driver.

Sure.

> around power management functionality, so you're not going to get that if
> none of these are enabled. Even if CONFIG_PM, it's not going to be called
> unless APM is up and running.

Well, actually APM or acpi reading the source, but yes.

> The BIOS is supposed to restore all the PCI config space, but we all know
> how well the BIOS does what it's supposed to reliably.

Indeed :-) I seem to be having difficulty just making it return from
the call at all.

> The suspend resume events are triggered by the APM subsystem. You won't
> get them without it.

The events, yes - or the ACPI subsystem, I think - at least it
seems to send power management events.

> ACPI suspend has not been implemented fully yet, so you're not going to
> get good results anyway..

So it would seem :-)

Is there a good way to debug apm.c BIOS calls (beyond a disassembler)?

--
Alex Bligh
