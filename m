Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262925AbVGHWuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262925AbVGHWuc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbVGHWsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:48:37 -0400
Received: from smtpgate.newisys.com ([208.190.191.186]:5806 "EHLO
	mail2.newisys.com") by vger.kernel.org with ESMTP id S262940AbVGHWqk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:46:40 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Instruction Tracing for Linux
Date: Fri, 8 Jul 2005 17:46:35 -0500
Message-ID: <DC392CA07E5A5746837A411B4CA2B713010BE544@sekhmet.ad.newisys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Instruction Tracing for Linux
Thread-Index: AcWECh5/2AyXxVPeSkaPWuSMVL32pgABJceg
From: "Adnan Khaleel" <Adnan.Khaleel@newisys.com>
To: "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

Would it be possible for you to send me the source to the single stepping code. It may be
too slow but it might prove to be sufficient for some simple benchmarks I guess.

Thanks a million.

Adnan

-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de]
Sent: Friday, July 08, 2005 5:12 PM
To: Adnan Khaleel
Cc: ak@suse.de; linux-kernel@vger.kernel.org
Subject: Re: Instruction Tracing for Linux


On Fri, Jul 08, 2005 at 03:49:47PM -0500, Adnan Khaleel wrote:
> Thanks for your suggestions. I have been working with Simics, SimNow and Bochs. I've had mixed luck with all of them. Although Simics should be the most promising, I've really had
> an uphill struggle with it especially when it comes to x86-64. I've been playing around with Bochs and most likely will end up using that but it has its drawbacks as well. 

I haven't tested any recent versions, but the original development
was near mostly done with Simics and it did work well for me.

iirc there was a recent bug that the optimized memcpy or memset
in the glibc didn't like a CPU returning 0 bytes of cache size and
Simics did that. You might have run into that. It should be
fixed now.

Bochs used to be quite buggy on the x86-64 department and didn't do
multi processor, but that also might have changed. It is significantly
slower than the others.

> 
> Even if I can't trace the kernel, is there anything available for just the user space stuff?

The AMD CodeAnalyst for Linux has a simulator that first collects 
a trace and then runs that in a CPU model.  I assume it does
first single stepping. It's unfortunately binary only.

If slow single stepping is enough it's reasonably easy to write
something yourself too. I have old example source that implements
single stepping.

However I doubt any of them are capable of running the bigger
benchmarks.

-Andi
