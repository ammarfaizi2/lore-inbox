Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267602AbUJBXDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267602AbUJBXDx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 19:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267607AbUJBXDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 19:03:53 -0400
Received: from mail.aei.ca ([206.123.6.14]:22770 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S267602AbUJBXDv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 19:03:51 -0400
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-rc3-mm1 build failure
Date: Sat, 2 Oct 2004 19:03:39 -0400
User-Agent: KMail/1.7
Cc: Norbert Preining <preining@logic.at>, linux-kernel@vger.kernel.org
References: <20041002091644.GA8431@gamma.logic.tuwien.ac.at> <20041002022921.0e1aceb3.akpm@osdl.org> <200410021440.45194.edt@aei.ca>
In-Reply-To: <200410021440.45194.edt@aei.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410021903.39328.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 October 2004 14:40, Ed Tomlinson wrote:
> On Saturday 02 October 2004 05:29, Andrew Morton wrote:
> > Norbert Preining <preining@logic.at> wrote:
> > >
> > > ..
> > >    LD      .tmp_vmlinux1
> > >  arch/i386/kernel/built-in.o(.text+0x111f5): In function `end_level_ioapic_irq':
> > >  : undefined reference to `irq_mis_count'
> > >  kernel/built-in.o(.text+0x1eba7): In function `ack_none':
> > >  : undefined reference to `ack_APIC_irq'
> > >  make[1]: *** [.tmp_vmlinux1] Fehler 1
> > >  make[1]: Leaving directory `/usr/src/linux-2.6.9-rc3-mm1'
> > 
> > hm, that's clever.
> > 
> > See if arch/i386/kernel/io_apic.c needs
> > 
> > #include <asm/io_apic.h>
> > 
> > and if not, please send the .config.
> 
> To get it to build here I had to add the above include to hardirq.h

Of course then init stalls in boot just as it normally enables the usb mouse.
Has anyone been playing with the input layer?

Ed
