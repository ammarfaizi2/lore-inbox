Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316997AbSHKSQu>; Sun, 11 Aug 2002 14:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317544AbSHKSQu>; Sun, 11 Aug 2002 14:16:50 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:60946 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316997AbSHKSQt>;
	Sun, 11 Aug 2002 14:16:49 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208111820.g7BIKPd172856@saturn.cs.uml.edu>
Subject: Re: klibc development release
To: oxymoron@waste.org (Oliver Xymoron)
Date: Sun, 11 Aug 2002 14:20:25 -0400 (EDT)
Cc: landley@trommello.org (Rob Landley), hpa@zytor.com (H. Peter Anvin),
       linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <Pine.LNX.4.44.0208111032001.25011-100000@waste.org> from "Oliver Xymoron" at Aug 11, 2002 10:56:06 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron writes:
> On Sun, 11 Aug 2002, Rob Landley wrote:

>> How about partition detection?  When initramfs goes in that's one of the
>> things they're threatening to move to userspace.  Also lots of the hardware
>> detection and setup (ACPI, hotplug style PCI probing...)
...
> It ought not be any more tightly bound than regular libc. Isn't that the
> point? If it still depends on non-generic services in the kernel, then we
> haven't succeeded in pulling it all the way into userspace.

Klibc is a neat hack, but makes little sense. In the end we wind up
with _more_ code to maintain, not less. The boot process becomes
more complicated too. A microkernel by any other name still smells. :-)
Not all of us have 2 GHz boxes BTW.

Moving partition code out of the kernel is just begging for bugs
and limited functionality. The EVMS people have the right idea.
Does anyone else remember the user-space isapnp disaster? I do.
Users everywhere were screaming "my sound card won't work".

