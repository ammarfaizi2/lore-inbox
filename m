Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131057AbQLUNCG>; Thu, 21 Dec 2000 08:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131042AbQLUNB4>; Thu, 21 Dec 2000 08:01:56 -0500
Received: from whiterose.net ([199.245.105.145]:8800 "EHLO whiterose.net")
	by vger.kernel.org with ESMTP id <S131039AbQLUNBn>;
	Thu, 21 Dec 2000 08:01:43 -0500
Date: Thu, 21 Dec 2000 07:31:18 -0500 (EST)
From: M Sweger <mikesw@whiterose.net>
To: linux-kernel@vger.kernel.org
Subject: Re: linux 2.2.19pre1 oops on cpuid (fwd)
Message-ID: <Pine.LNX.4.21.0012210731030.27401-100000@whiterose.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



---------- Forwarded message ----------
Date: Wed, 20 Dec 2000 15:56:38 -0500 (EST)
From: Alan Cox <alan@redhat.com>
To: M Sweger <mikesw@whiterose.net>
Cc: alan@redhat.com
Subject: Re: linux 2.2.19pre1 oops on cpuid (fwd)

> How would I activate the usb-serial in such a way as to activate the
> /dev/usb/tts/{0,1} instead of /dev/ttyUSB0. The /dev/ttyUSB) shows
> up correctly now in /proc, but I'd like to test and see the other one.

Thats for 2.4 and devfs. Probably works on 2.2 + devfs patch

>    I have linux 2.2.19pre1 and have compiled the cpuid as a module. The
> kernel will oops if the cpuid module isn't loaded and one does
> /cat/dev/cpu/0/cpuid or /cat/dev/cpu/1/cpuid.

Yeah. That one should get squashed for pre4

>      Question: When the cpuid module is loaded and I do a
> cat/dev/cpu/0/cpuid it gives me a code "C" forover. What does this code
> mean. I'm stil new to what it will be used for. Moreover, is there
> a  list of all the possible code values it may take on for intel
> processors vs. other processor types?

Its a binary not ascii file for the cpuid() instruction results off each 
CPU. See the intel cpu docs on the cpuid instruction and go from there

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
