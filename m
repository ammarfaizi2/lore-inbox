Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130471AbRDJRi7>; Tue, 10 Apr 2001 13:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbRDJRiu>; Tue, 10 Apr 2001 13:38:50 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:7405 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S130446AbRDJRid>;
	Tue, 10 Apr 2001 13:38:33 -0400
Message-ID: <3AD34518.2A43A346@mandrakesoft.com>
Date: Tue, 10 Apr 2001 13:38:32 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Axel Thimm <Axel.Thimm@physik.fu-berlin.de>
Cc: "Manuel A. McLure" <mmt@unify.com>, linux-kernel@vger.kernel.org
Subject: Re: Still IRQ routing problems with VIA
In-Reply-To: <419E5D46960FD211A2D5006008CAC79902E5C1A0@pcmailsrv1.sac.unify.com> <20010410193125.A31792@pua.domain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Thimm wrote:
> 0.7.[2,3] are the usb devices. BIOS (and 2.2 kernels) had them at IRQ 5. 2.4
> somehow picks the irq of the ethernet adapter, iqr 11, instead.
> 
> At least usb is then unusable.
> 
> As you say that you have the same board, what is the output of dump_pirq - are
> your link values in the set of {1,2,3,5} or are they continuous 1-4? Maybe you
> are lucky - or better say, I am having bad luck :(

Changing '#undef DEBUG' to '#define DEBUG 1' in
arch/i386/kernel/pci-i386.h is also very helpful.  Can you guys do so,
and post the 'dmesg -s 16384' results to lkml?  This includes the same
information as dump_pirq, as well as some additional information.

Note that turning "Plug-n-Play OS" off in BIOS setup typically fixes
many interrupt routing problems -- but Linux 2.4 should now have support
for PNP OS:Yes.  Clearly there appear to be problems with that support
on some Via hardware.

Note that you should have "Plug-n-Play OS: Yes" when generated the
requested 'dmesg' output.

Regards,

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
