Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAKCAP>; Wed, 10 Jan 2001 21:00:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131330AbRAKCAF>; Wed, 10 Jan 2001 21:00:05 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:58118 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131257AbRAKB7w>; Wed, 10 Jan 2001 20:59:52 -0500
Message-ID: <3A5D1392.281E2A83@transmeta.com>
Date: Wed, 10 Jan 2001 17:59:46 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: "Dunlap, Randy" <randy.dunlap@intel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: The latest instance in the A20 farce
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDEF8@orsmsx31.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dunlap, Randy" wrote:
> 
> I'm not sure about this, but I'm wondering if the
> Fixed (as in Static) ACPI Description Table (FADT)
> can indicate that the platform is a legacy-free system.
> 

Parsing ACPI is a nightmare on steroids.  That is just Not An Option[TM]
in a < 10K bootstrap routine.

> 
> > Worse, they define that port 92h, bit 1, is no longer
> > A20M#... but they
> > don't forbid the system from using it for other things.
> 
> I don't quite see it that way.  Where do you see that?
> Maybe it just needs to be more explicit.
> 

It probably was *intended*, but it isn't *specified*, and in fact some
manufacturers have been known to abuse this bit.

> Ch. 3 (SYS-0047) says that port 92h:bit 1 doesn't toggle/affect A20M#.
> Appendix A says that port 92h is (still?) "System Control Port A"
> (not defined here AFAIK).
> (I haven't checked all of the other chapters/appendices.)
> 

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
