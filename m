Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280289AbRJaQhV>; Wed, 31 Oct 2001 11:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280291AbRJaQhB>; Wed, 31 Oct 2001 11:37:01 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:33808 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S280289AbRJaQgy>;
	Wed, 31 Oct 2001 11:36:54 -0500
Message-ID: <3BE028CA.2010204@epfl.ch>
Date: Wed, 31 Oct 2001 17:37:30 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: i820 agp support ?
In-Reply-To: <3BDFF640.4020002@epfl.ch> <1004544209.1209.26.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:


> 
> I will work on support for the i820 ... I don't believe there is any
> particular reason we don't support it.  Please give me the output of
> 
> 	/sbin/lspci -s 0 -v -n
> 
> on your i820 machine.



Hello


Here is the output I get :


00:00.0 Class 0600: 8086:2500 (rev 03)
         Flags: bus master, fast devsel, latency 0
         Memory at f8000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0

01:00.0 Class 0300: 10de:0028 (rev 11)
         Subsystem: 1048:0c20
         Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 10
         Memory at f4000000 (32-bit, non-prefetchable) [size=16M]
         Memory at f6000000 (32-bit, prefetchable) [size=32M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [60] Power Management version 1
         Capabilities: [44] AGP version 2.0

I was trying to tweak myself the agp code (well, mostly by copying the 
intel_generic_setup stuff to a intel_i820_setup stuff, but I guess there 
is a more clever way !). Maybe I can help with this ?

I guess that the device id's that must be added into 'agp.h' look like 
this :

#ifndef PCI_DEVICE_ID_INTEL_820_0
#define PCI_DEVICE_ID_INTEL_820_0       0x2500
#endif
/* [...] */
#ifndef PCI_DEVICE_ID_INTEL_820_1
#define PCI_DEVICE_ID_INTEL_820_1       0x250f
#endif

is it correct ?


Nicolas.
-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)


