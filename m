Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135437AbRDRWcM>; Wed, 18 Apr 2001 18:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135441AbRDRWcC>; Wed, 18 Apr 2001 18:32:02 -0400
Received: from m264-mp1-cvx1a.col.ntl.com ([213.104.69.8]:10114 "EHLO
	[213.104.69.8]") by vger.kernel.org with ESMTP id <S135435AbRDRWbw>;
	Wed, 18 Apr 2001 18:31:52 -0400
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Simon Richter'" <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD9D@orsmsx35.jf.intel.com>
From: John Fremlin <chief@bandits.org>
Date: 18 Apr 2001 23:30:13 +0100
In-Reply-To: "Grover, Andrew"'s message of "Wed, 18 Apr 2001 14:46:16 -0700"
Message-ID: <m2wv8h3kp6.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" <andrew.grover@intel.com> writes:

[...]

> > ACPI != PM. I don't see why ACPI details should be exposed to PM
> > interface at all.
> 
> ACPI has by far the richest set of capabilities. It is a superset of
> APM.  Therefore a combined APM/ACPI interface is going to look a lot
> like an ACPI interface.

First, lets stop being so Intel/x86 centric ;-)
There are more PM interfaces than APM/ACPI as Stephen Rothwell pointed
out to me: more are already supported by the kernel. PPC has one, ARM
has one, etc. And that's not even touching on UPSs and miscellaneous
portable whatnots with their own special PM bits and pieces like IBM
laptops.

ACPI might be able to handle all that but it would require a very
complex interface, if what I've seen of ACPI is anything to go by. Is
this correct?

A much simpler interface might not lose much functionality.

> IMHO an abstracted interface at this point is overengineering. Maybe
> later it will make sense, though.

Each PM scheme has its own daemon and suspend/sleep tools at the
moment. It makes sense to have just one daemon and toolset so that
advanced functionality can be shared. Should the kernel present a
common interface like HID, or should the daemon be able to understand
all the various protocols (like gpm for mice)?

-- 

	http://www.penguinpowered.com/~vii
