Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbTBSTD2>; Wed, 19 Feb 2003 14:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbTBSTD2>; Wed, 19 Feb 2003 14:03:28 -0500
Received: from mrelay1.cc.umr.edu ([131.151.1.120]:47544 "EHLO smtp.umr.edu")
	by vger.kernel.org with ESMTP id <S261645AbTBSTD1> convert rfc822-to-8bit;
	Wed, 19 Feb 2003 14:03:27 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: 2.4.20 amd speculative caching
Date: Wed, 19 Feb 2003 13:13:28 -0600
Message-ID: <A5D66E6B6F478B48A3CEF22AA4B9FCA3012E55@umr-mail1.umr.edu>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.20 amd speculative caching
Thread-Index: AcLYP9MjR2ILod7bQuSArDT3cTtloQACUc0w
From: "Sowadski, Craig Harold (UMR-Student)" <sowadski@umr.edu>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I didn't mean to state that the bug was in the processor. 

The systems consistently hard locks in any accelerated application. The
mem=nopentium does not seem to help at all.

Are there any dependencies that must be taken care of to implement the
new fix? Also, should I be seeing any dmesg output from this new
implementation?

Are there any debugging techniques I could use to track the cause? (I
have no log outputs due to hard lock)

If it helps, here is my hardware config:

	AMD Duron 1300MHZ
	MSI K7T Turbo-2
	ATI Radeon 7500 w/64mb
	Redhat 8.0
Thanks again for any information,
	
	Craig Sowadski (sowadski@umr.edu)
	

-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de] 
Sent: Wednesday, February 19, 2003 11:54 AM
To: Sowadski, Craig Harold (UMR-Student)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 amd speculative caching

"Sowadski, Craig Harold (UMR-Student)" <sowadski@umr.edu> writes:

> I have recently upgraded to an AMD processor that is exhibiting the
> problems with the AMD speculative caching bug. Kernel 2.4.19 seems to

It's actually not an AMD bug, but an Linux bug that assumed undefined
x86
behaviour to behave well. 

> fix the problem with the temporary work-around (adv-spec-cache patch).
I
> have noticed that the patch has been removed from 2.4.20 and I am
> wondering if there is some other mechanism that is supposed to address
> this issue. Currently I have a  2.4.20 kernel with same configuration
as

Yes, there is a new mechanism to address the problem the adv-spec-cache
patch solved. It enforces that there are not conflicting cache
attributes
for memory mappings.

> my 2.4.19 and the problem seems to have reappeared.

What problem exactly? And does mem=nopentium help ?

-Andi
