Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVBGOjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVBGOjt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 09:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVBGOj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 09:39:29 -0500
Received: from mail.gmx.de ([213.165.64.20]:24710 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261432AbVBGOfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 09:35:55 -0500
X-Authenticated: #26200865
Message-ID: <42077CFD.7030607@gmx.net>
Date: Mon, 07 Feb 2005 15:36:45 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: Adam Sulmicki <adam@cfar.umd.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, Jon Smirl <jonsmirl@gmail.com>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Li-Ta Lo <ollie@lanl.gov>
Subject: Re: [RFC] Reliable video POSTing on resume
References: <e796392205020221387d4d8562@mail.gmail.com>  <420217DB.709@gmx.net> <4202A972.1070003@gmx.net>  <20050203225410.GB1110@elf.ucw.cz>  <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>  <1107485504.5727.35.camel@desktop.cunninghams>  <9e4733910502032318460f2c0c@mail.gmail.com>  <20050204074454.GB1086@elf.ucw.cz>  <9e473391050204093837bc50d3@mail.gmail.com>  <20050205093550.GC1158@elf.ucw.cz> <1107695583.14847.167.camel@localhost.localdomain> <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu> <42077AC4.5030103@grupopie.com>
In-Reply-To: <42077AC4.5030103@grupopie.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques schrieb:
> Adam Sulmicki wrote:
> 
>>
>> hi all,
>>     I would like point to work done by Li-Ta Lo.
>>
>>     It allows you to completely initalize the VGA BIOS w/out using
>>     PC BIOS at all.
>>
>>    
>> http://www.clustermatic.org/pipermail/linuxbios/2005-January/010236.html
>>     unforunatelly the information the web is somewhat sparse, but
>>     you can get more info by following the archive of the
>>     thread (which head I listed above) and perhaps by posting to
>>     linuxbios mailing list (Ollie, is somewhat buy those days with his
>>     new baby).
> 
> 
> I did some work on reducing the core x86 emulation code (and have my
> name mentioned in that thread for it). The code size went from 59kB to
> 38kB. This does not include emulation of BIOS functions or hardware
> (like the standard PC timer).
> 
> It seems to me that x86 emulation in the kernel is the way to go because:
> 
> [...]
> 
> 3 - it's always there and can be executed at *any* time: booting,
> returning from suspend, etc. Also it would allow the VESA framebuffer
> driver to change graphics mode at any time (for instance).

OK, and what would force you to do the above in the kernel? If the code
lives in initramfs, it can be called very early, too.


And how many competing implementations of video helpers/emulation code
do we have now?

- scitechsoft emu
- linuxbios emu
- etc. (I surely forgot some)


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
