Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbTJIWNx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 18:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTJIWNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 18:13:53 -0400
Received: from mail.gmx.de ([213.165.64.20]:21167 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261779AbTJIWNw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 18:13:52 -0400
X-Authenticated: #7204266
Cc: Chris Wright <chrisw@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Horrible ordeals with ACPI, APIC and HIGHMEM (2.6.0-test* and -ac kernels)
References: <oprwsg9wfc9y0cdf@mail.gmx.net> <20031009140523.A18065@build.pdx.osdl.net> <oprwsoirf09y0cdf@mail.gmx.net> <20031009145839.A18072@build.pdx.osdl.net>
Message-ID: <oprwsqppse9y0cdf@mail.gmx.net>
From: Martin Aspeli <optilude@gmx.net>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Thu, 09 Oct 2003 23:14:03 +0100
In-Reply-To: <20031009145839.A18072@build.pdx.osdl.net>
User-Agent: Opera7.20/Win32 M2 build 3144
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> fixes acpi pci link allocation which could pick a bad irq causing an
> interrupt storm.  typical symptom was hang on boot.

Well, the hang only occurs when Local APIC was enabled. If Local APIC is 
taken out of the kernel, it boots, but events/0 starts eating my entire 
CPU and the fan is constantly on. I can't tell whether this is because 
events/0 is eating my CPU and hence it's running hot, or if it's 
(partially) unrelated.

I'm still a little lost as to what Local APIC does (apart from being an 
interrupt controller) or how it's related to ACPI (apart from obvious 
puns), or indeed whether or not my Penium-M has one.

You say stray ACPI events could cause keventd to chew CPU. It does seem 
likely. What would cause a runaway ACPI event? How would I stop one (apart 
 from acpi=off, of course, which leaves me IRQ less).

Conversely, I suppose - is it possible to give IRQs to my sound card and 
the four or five other unidentified pieces of hardware that get no IRQ at 
boot, manually even? I'm a little worried this may leave me fan-less, 
although the BIOS seems to be turning the fan on sometimes if I boot with 
acpi=off.

>> And why do things run like a 286 when I enable HIGHMEM?
> I don't know, it shouldn't.

I most whole-heartedly agree!

Thank you for all your help!

Martin

-- 
Using M2, Opera's revolutionary e-mail client: http://www.opera.com/m2/
