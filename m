Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132971AbRDRBzJ>; Tue, 17 Apr 2001 21:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132970AbRDRBy7>; Tue, 17 Apr 2001 21:54:59 -0400
Received: from m69-mp1-cvx1b.col.ntl.com ([213.104.72.69]:28320 "EHLO
	[213.104.72.69]") by vger.kernel.org with ESMTP id <S132969AbRDRByp>;
	Tue, 17 Apr 2001 21:54:45 -0400
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD91@orsmsx35.jf.intel.com>
From: John Fremlin <chief@bandits.org>
Date: 18 Apr 2001 02:54:00 +0100
In-Reply-To: "Grover, Andrew"'s message of "Tue, 17 Apr 2001 17:07:30 -0700"
Message-ID: <m2oftvkm6f.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" <andrew.grover@intel.com> writes:

> [do we want to move this to linux-power?]

I'm happy to as long as I'm cc'd.

[...]

IMHO the pm interface should be split up as following:

        (1) Battery status, power status, UPS status polling. It
        should be possible for lots of processes to do this
        simultaneously. [That does not prohibit a single process
        querying the kernel and all the others querying it.]

        (2) Funky events happening to the physical machine, like a
        button being pressed, the case being closed, etc. [Should this
        include battery low warnings, power status changes? I don't
        know.]

        (3) Sending the machine to sleep, turning it off. It should be
        possible to do this from userspace ;-)

Am I missing anything? Of course (1) and (2) could be combined into a
single daemon.

ATM the area is fraught with incompatibility. There are a ridiculous
number of power management systems - one per architecture almost. Each
has a different kernel-userspace interface. Every UPS has its own
interface too (?) ;-)

> There should be only one PM policy agent on the system. 

Why?

As far as I see it, only some people need polling capabilities -
i.e. those on battery or UPS. Why should they be subjected to the
bloat etc. And those on battery might want multiple policies as Alan
pointed out.

[...]

-- 

	http://www.penguinpowered.com/~vii
