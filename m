Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269868AbUJGXBg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269868AbUJGXBg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 19:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268232AbUJGXB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 19:01:26 -0400
Received: from holomorphy.com ([207.189.100.168]:38098 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269888AbUJGWp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 18:45:59 -0400
Date: Thu, 7 Oct 2004 15:45:53 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] APIC physical broadcast for i82489DX
Message-ID: <20041007224553.GY9106@holomorphy.com>
References: <200410071609.i97G9reQ003072@hera.kernel.org> <20041007183203.GW9106@holomorphy.com> <Pine.LNX.4.58L.0410072244570.27899@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0410072244570.27899@blysk.ds.pg.gda.pl>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, William Lee Irwin III wrote:
>> This is the same as version <= 0xf || version >= 0x14; I'm rather

On Thu, Oct 07, 2004 at 11:12:55PM +0100, Maciej W. Rozycki wrote:
>  I suppose defining a macro called something like APIC_XAPIC(x) to (x >= 
> 0x14) might actually have some sense, although unlike with the i82489DX, 
> there is no promise for this to be always true.

There is a presumption there that higher APIC revisions will be
backward-compatible and will have comparable version numbers, yes.


On Thu, 7 Oct 2004, William Lee Irwin III wrote:
>> suspicious, as the docs have long since been purged, making this

On Thu, Oct 07, 2004 at 11:12:55PM +0100, Maciej W. Rozycki wrote:
>  AFAIK i82489DX documents were never available online and I suppose they
> might have never existed in a PDF form.  You could have ordered hardcopies
> in mid 90's.

Which probably either predated or coincided with my earliest use of
computers.


On Thu, 7 Oct 2004, William Lee Irwin III wrote:
>> hopeless for anyone without archives (or a good memory) dating back to
>> that time to check. All that's really needed is citing the version that
>> comes out of the version register and checking other APIC
>> implementations to verify they don't have versions tripping this check,

On Thu, Oct 07, 2004 at 11:12:55PM +0100, Maciej W. Rozycki wrote:
>  The APIC_INTEGRATED() macro reflects the range reserved for the i82489DX.  
> Both "Multiprocessor Specification" and "IA-32 Intel Architecture Software
> Developer's Manual, Vol.3" which are available online specify it clearly
> and explicitly.  AFAIK, there is no integrated APIC implementation that
> would violate it (unlike with I/O APICs), so what's the problem?  If a 
> buggy chip appears, we can revisit this assumption.

Only documentation; this is probably as good as it gets, so I'm happy
with this level of explanation, for instance, saying what the revision
numbers are.


On Thu, 7 Oct 2004, William Lee Irwin III wrote:
>> the latter of which is feasible for those relying on still-extant
>> documentation. Better yet would be dredging up the docs... So, what is
>> the range of the version numbers reported by i82489DX's?

On Thu, Oct 07, 2004 at 11:12:55PM +0100, Maciej W. Rozycki wrote:
>  The i82489DX datasheet documents 0x01 for the chip and the
> implementations I've encountered so far agree.

Since it's not available online this will have to do. I seem to have
turned up some vague evidence they were made into PDF's ca. 1993, but
don't really expect that to mean anything.


-- wli
