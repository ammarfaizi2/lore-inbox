Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422996AbWJFWb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422996AbWJFWb4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422995AbWJFWb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:31:56 -0400
Received: from outbound-blu.frontbridge.com ([65.55.251.16]:50604 "EHLO
	outbound3-blu-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1422996AbWJFWbz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:31:55 -0400
X-BigFish: VP
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [discuss] Re: Please pull x86-64 bug fixes
Date: Fri, 6 Oct 2006 17:31:46 -0500
Message-ID: <1449F58C868D8D4E9C72945771150BDF46F8FD@SAUSEXMB1.amd.com>
In-Reply-To: <200610070001.01752.rjw@sisk.pl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [discuss] Re: Please pull x86-64 bug fixes
Thread-Index: AcbplADBZxklJDKRTcS5QYEDSYAHLgAAKJ+g
From: "Duran, Leo" <leo.duran@amd.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>, "Linus Torvalds" <torvalds@osdl.org>
cc: "Arjan van de Ven" <arjan@infradead.org>, "Jeff Garzik" <jeff@garzik.org>,
       "Andi Kleen" <ak@suse.de>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 06 Oct 2006 22:31:45.0595 (UTC)
 FILETIME=[347368B0:01C6E997]
X-WSS-ID: 693806DB1L85213766-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, lets' take K8 processor performance states (p-states) as an example:
BIOS, which should know 'best' about a given platform, needs to
communicate to the OS what 'voltage' (VID code) is correct for given
'frequency' (FID),
and it can do that via ACPI processor tables (_PSS). Otherwise, OS code
is left with having to manage a HUGE amount 'specifics' (processor
models), and endless driver revisions to account for new parts.

So, one can argue that there's merit on having ACPI, it's just a shame
when BIOS doesn't get it right! (thus the justification for lack of
'trust'... the same can probably be said about other BIOS issues, not
just ACPI)

Leo Duran


-----Original Message-----
From: Rafael J. Wysocki [mailto:rjw@sisk.pl] 
Sent: Friday, October 06, 2006 5:01 PM
To: Linus Torvalds
Cc: Arjan van de Ven; Jeff Garzik; Andi Kleen; discuss@x86-64.org;
linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: Please pull x86-64 bug fixes

On Friday, 6 October 2006 18:07, Linus Torvalds wrote:
> 
> On Fri, 6 Oct 2006, Arjan van de Ven wrote:
> >
> > we can do a tiny bit better than the current code; some chipsets
have
> > the address of the MMIO region stored in their config space; so we
can
> > get to that using the old method and validate the acpi code with
that.
> 
> Yes. I think trusting ACPI is _always_ a mistake. It's insane. We
should 
> never ask the firmware for any data that we can just figure out
ourselves.
> 
> And we should tell all hardware companies that firmware tables are
stupid, 
> and that we just want to know what the hell the registers MEAN!
> 
> I've certainly tried to tell Intel that. I think they may even have
heard 
> me occasionally.
> 
> I can't understand why some people _still_ think ACPI is a good idea..

I violently agree.

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller





