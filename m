Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132213AbRBDSSI>; Sun, 4 Feb 2001 13:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132225AbRBDSR6>; Sun, 4 Feb 2001 13:17:58 -0500
Received: from quattro.sventech.com ([205.252.248.110]:61452 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S132214AbRBDSRz>; Sun, 4 Feb 2001 13:17:55 -0500
Date: Sun, 4 Feb 2001 13:17:54 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Andi Kleen <ak@suse.de>
Cc: "Hen, Shmulik" <shmulik.hen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel memory allocations alignment
Message-ID: <20010204131753.L22751@sventech.com>
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B2711B@hasmsx52.iil.intel.com> <oup66iq8ju2.fsf@pigdrop.muc.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <oup66iq8ju2.fsf@pigdrop.muc.suse.de>; from Andi Kleen on Sun, Feb 04, 2001 at 06:00:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 04, 2001, Andi Kleen <ak@suse.de> wrote:
> "Hen, Shmulik" <shmulik.hen@intel.com> writes:
> 
> > Actually yes. We were warned that on IA64 architecture the system will halt
> > when accessing any type of variable via a pointer if the pointer does not
> > contain an aligned address matching that type. Until now we were using a
> 
> That will need to be fixed with a handler anyways, the network stack requires 
> unaligned accesses. If the IA64 port doesn't handle that it it's buggy and 
> trivially remotely crashable.

That ia64 port now supports unaligned accesses in kernel mode. (via the
latest patch)

It was more a debugging aid in the beginning than inability to do.

> Of course it'll always be much faster to use aligned accesses that do not
> need an exception.

Absolutely.

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
