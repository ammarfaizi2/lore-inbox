Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135210AbRAJPcJ>; Wed, 10 Jan 2001 10:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135524AbRAJPb7>; Wed, 10 Jan 2001 10:31:59 -0500
Received: from lca0042.lss.emc.com ([168.159.120.42]:4510 "EHLO
	lca0042.lss.emc.com") by vger.kernel.org with ESMTP
	id <S135210AbRAJPbv>; Wed, 10 Jan 2001 10:31:51 -0500
To: linux-kernel@vger.kernel.org
Cc: Mike Harrold <mharrold@cas.org>
Subject: Re: * 4 converted to << 2 for networking code
In-Reply-To: <200101101518.KAA11519@mah21awu.cas.org>
From: Chris Jones <clj@emc.com>
Date: 10 Jan 2001 10:31:34 -0500
In-Reply-To: Mike Harrold's message of "Wed, 10 Jan 2001 10:18:38 -0500 (EST)"
Message-ID: <hplmsjs9t5.fsf@lca2240.lss.emc.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Harrold <mharrold@cas.org> writes:

[...]

  My feeling is that it shouldn't matter if you use <<2 or *4 even if the
  compiler optimises - one would hope that the compiler would optimise to
  the fastest in both directions.

I agree this should be left to the compiler.  The programmer should write *4
when multiplying by 4 and <<2 when shifting left by 2.  In the case that
sparked this (converting counts of 32 bit units to counts of octets),
multiplication is the proper conversion operation.

(If performance is truly critical AND profiling shows that writing <<2 instead
of *4 makes a significant difference, doing the shift might be called for.  I
hardly believe that's the case here, and the fact that the code has to run on
several architectures and be compiled by various compilers makes it less likely
that this change is a clearcut win.)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
