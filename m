Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRDJVMK>; Tue, 10 Apr 2001 17:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRDJVMA>; Tue, 10 Apr 2001 17:12:00 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33155 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129359AbRDJVLu>;
	Tue, 10 Apr 2001 17:11:50 -0400
Message-ID: <3AD3770E.8AA6D989@mandrakesoft.com>
Date: Tue, 10 Apr 2001 17:11:42 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Manuel A. McLure" <mmt@unify.com>
Cc: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>, linux-kernel@vger.kernel.org
Subject: Re: Still IRQ routing problems with VIA
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C1A6@pcmailsrv1.sac.unify.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Manuel A. McLure" wrote:
> Jeff Garzik said...
> > Changing '#undef DEBUG' to '#define DEBUG 1' in
> > arch/i386/kernel/pci-i386.h is also very helpful.  Can you guys do so,
> > and post the 'dmesg -s 16384' results to lkml?  This includes the same
> > information as dump_pirq, as well as some additional information.
> 
> Here's my dmesg output - I tried with both PNP: Yes and PNP: No and the
> dmesg outputs were exactly the same modulo a Hz or two in the processor
> speed detection.

Thanks.  I'm building a database of these.  There is definitely an issue
with Via and interrupt routing.  Hopefully I can collate this data soon
and figure out what's going on.  I need to find some Via hardware for
myself, too, since I only have an old Via-based laptop which works 100%
;-)


> I do have an IRQ for my VGA since the instructions for my card (a Voodoo 5
> 5500) specifically say an IRQ is needed.

I wonder though... In my mind this is a driver not hardware issue.  If
the XFree86 and/or Linux console driver do not use the IRQ, you need not
have BIOS assign one.  If you are feeling dangerous, try turning the VGA
IRQ assignment off in BIOS and see if things melt/explode/kick ass.

Regards,

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
