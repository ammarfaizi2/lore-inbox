Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135640AbRDSMKF>; Thu, 19 Apr 2001 08:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135639AbRDSMJ5>; Thu, 19 Apr 2001 08:09:57 -0400
Received: from t2.redhat.com ([199.183.24.243]:5619 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S135640AbRDSMJs>; Thu, 19 Apr 2001 08:09:48 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD9D@orsmsx35.jf.intel.com> 
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD9D@orsmsx35.jf.intel.com> 
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'John Fremlin'" <chief@bandits.org>,
        "'Simon Richter'" <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 19 Apr 2001 13:04:00 +0100
Message-ID: <6257.987681840@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


andrew.grover@intel.com said:
>  IMHO an abstracted interface at this point is overengineering. Maybe
> later it will make sense, though. 

Absolutely not. It makes sense now. The abstracted interface is not required
just to combine the interface to APM and ACPI. What John said was 
"ACPI != PM". Note that APM != PM either. 

We have people who write _real_ code (esp. for embedded systems) to do power 
management. None of this UDI-written-in-bytecode style stuff - real C code. 
I.e. "the preferred form of the work for making modifications to it" :) 

_That_ is the first-class citizen here, and _that_ is the thing for which we
require a generic power management API, allowing userspace to set and manage
the power management policies for individual devices, etc., as well as 
managing the system-wide sleep macrostates.

It may happen that ACPI and the real native power management code can
happily share an interface. Where there's a conflict, though, the native
implementations should define the interface, and ACPI needs to try to fit
in.

--
dwmw2


