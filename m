Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVBKBqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVBKBqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 20:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVBKBqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 20:46:18 -0500
Received: from pop.gmx.net ([213.165.64.20]:42130 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261999AbVBKBqQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 20:46:16 -0500
X-Authenticated: #26200865
Message-ID: <420C0EAF.4000606@gmx.net>
Date: Fri, 11 Feb 2005 02:47:27 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Li-Ta Lo <ollie@lanl.gov>
CC: Pavel Machek <pavel@ucw.cz>, Paulo Marques <pmarques@grupopie.com>,
       Adam Sulmicki <adam@cfar.umd.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jon Smirl <jonsmirl@gmail.com>, ncunningham@linuxmail.org,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kendall Bennett <kendallb@scitechsoft.com>
Subject: Re: [ACPI] Re: [RFC] Reliable video POSTing on resume
References: <4202DF7B.2000506@gmx.net>	 <1107485504.5727.35.camel@desktop.cunninghams>	 <9e4733910502032318460f2c0c@mail.gmail.com>	 <20050204074454.GB1086@elf.ucw.cz>	 <9e473391050204093837bc50d3@mail.gmail.com>	 <20050205093550.GC1158@elf.ucw.cz>	 <1107695583.14847.167.camel@localhost.localdomain>	 <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu>	 <42077AC4.5030103@grupopie.com> <42077CFD.7030607@gmx.net>	 <20050207160105.GF8040@elf.ucw.cz> <1107793204.2930.18.camel@logarithm.lanl.gov>
In-Reply-To: <1107793204.2930.18.camel@logarithm.lanl.gov>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li-Ta Lo schrieb:
> On Mon, 2005-02-07 at 09:01, Pavel Machek wrote:
> 
>>>>3 - it's always there and can be executed at *any* time: booting,
>>>>returning from suspend, etc. Also it would allow the VESA framebuffer
>>>>driver to change graphics mode at any time (for instance).
>>>
>>>OK, and what would force you to do the above in the kernel? If the code
>>>lives in initramfs, it can be called very early, too.
>>
>>It will be easier to debug in kernel than in initramfs, for
>>one. Kernel code is bad enough, but initramfs running while kernel is
>>not even initialized is going to be even more "fun".
> 
> One good thing about the emulator is it is very portable. There is
> virtually no stdlib dependency. We can freely move it between user
> and kernel space. When integrating the emulator into LinuxBIOS,
> we first tried to use it as an user space program and then "port" it
> into "kernel" space. The porting was done in a few days and the most
> of the time was spent fixing LinuxBIOS itself than doing any "porting".
> Actually, the same emulator source were used in both user and kernel
> space as a kind of regression test.

Do you have a kernel patch against a recent kernel? I'd like to try
the in-kernel emulator. A userspace variant would also be fine, provided
it solves the "VGA BIOS calls normal BIOS" type of problem I'm seeing
on my machine (Samsung P35 laptop with ATI Radeon Mobility 9700).


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
