Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129251AbQKPH6q>; Thu, 16 Nov 2000 02:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbQKPH60>; Thu, 16 Nov 2000 02:58:26 -0500
Received: from slc25.modem.xmission.com ([166.70.9.25]:5897 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129251AbQKPH6X>; Thu, 16 Nov 2000 02:58:23 -0500
To: andersen@codepoet.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org> <20001114011331.B1496@codepoet.org> <m1bsvia9bt.fsf@frodo.biederman.org> <20001115163012.B13732@codepoet.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Nov 2000 23:19:52 -0700
In-Reply-To: Erik Andersen's message of "Wed, 15 Nov 2000 16:30:12 -0700"
Message-ID: <m1g0ks8mlz.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen <andersen@codepoet.org> writes:

> On Tue Nov 14, 2000 at 07:59:18AM -0700, Eric W. Biederman wrote:
> > 
> > All mkelfImage does is the pasting of initrd's, command lines,
> > and just a touch of argument conversion code.
> 
> You can link in an initrd using linker magic, i.e.
>     $(OBJCOPY) --add-section=image=kernel --add-section=initrd=initrd.gz

Hmm this is certainly possible.
My impression is that this doesn't currently work on x86.
I would love to be wrong.

> This is done in ppc/boot/Makefile for example.  It might be a nice thing
> to add a .config option to optionally specify an initrd to link into
> the kernel image.  Similarly, several architectures have a CONFIG_CMDLINE
> which could also do the job (see arch/ppc/config.in for example).  
> 
> Presumably, by doing such things you could avoid needing to use mkelfImage.

Agreed.  And I would like to see that.
With the 2.4 code freeze it is too late to do that today. 
Also mkelfImage gives me backwards compatibility for now.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
