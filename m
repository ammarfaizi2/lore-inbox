Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVJaWQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVJaWQK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVJaWQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:16:10 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:34689 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964800AbVJaWQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:16:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:User-Agent;
  b=Abm2U1TMYXEybrtp0axb6eX5E+dzNDWN4dBqUOy6f9ZhLY2qOq2dOV0dEffL/dpSbMu1JYVlzTKuvCB+q7pBLBIDB1X4cENEHWnPVK5JHzofmr35HuaC/eDU0GCeGjMXg2mP6w85R33b1T3sJbpYKAO538umvAUDnERv3gJuIuo=  ;
Date: Mon, 31 Oct 2005 23:15:41 +0100
From: Borislav Petkov <bbpetkov@yahoo.de>
To: Aleksey Gorelov <Aleksey_Gorelov@Phoenix.com>
Cc: Borislav Petkov <bbpetkov@yahoo.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dbrownell@users.sourceforge.net, greg@kroah.com
Subject: Re: Linux 2.6.14 ehci-hcd hangs machine
Message-ID: <20051031221541.GA31948@gollum.tnic>
References: <0EF82802ABAA22479BC1CE8E2F60E8C376CE22@scl-exch2k3.phoenix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0EF82802ABAA22479BC1CE8E2F60E8C376CE22@scl-exch2k3.phoenix.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 09:53:15AM -0800, Aleksey Gorelov wrote:
> >-----Original Message-----
> >From: linux-kernel-owner@vger.kernel.org 
> >[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> >Borislav Petkov
> >Sent: Sunday, October 30, 2005 12:36 AM
> >To: Linus Torvalds
> >Cc: Linux Kernel Mailing List; 
> >dbrownell@users.sourceforge.net; greg@kroah.com
> >Subject: Re: Linux 2.6.14 ehci-hcd hangs machine
> >
> >On Thu, Oct 27, 2005 at 05:28:50PM -0700, Linus Torvalds wrote:
> >> 
> >> Ok, it's finally there. 
> >... and it still won't boot on my machine. It hangs while initializing
> >the ehci usb host controller saying:
> >
> ><snip>
> >...
> >[4294691.834000] usb usb3: Product: UHCI Host Controller
> >[4294691.840000] usb usb3: Manufacturer: Linux 2.6.14 uhci_hcd
> >[4294691.847000] usb usb3: SerialNumber: 0000:00:1d.2
> >[4294691.880000] hub 3-0:1.0: USB hub found
> >[4294691.885000] hub 3-0:1.0: 2 ports detected
> >[4294694.855000] ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level,
> >				low) -> IRQ 20
> >[4294694.864000] ehci_hcd 0000:00:1d.7: EHCI Host Controller
> >[4294694.870000] ehci_hcd 0000:00:1d.7: debug port 1
> ></snip>
> >
> >and dies. This bug is actually in there since 2.6.14-rc4 (see:
> >http://bugzilla.kernel.org/show_bug.cgi?id=5428) and David Brownell
> >supplied a patch which turned out to be useless eventually 
> >since _rebooting_ 
> >the kernel with the 'usb-handoff' (and without the patch) 
> >solved the problem. 
> >As it turns out, it actually solves the problem only for the 
> >reboot case.
> >My machine still hangs on an initial boot with and without 
> >'usb-handoff'.
> >.config attached.
> 
> Boris, 
> 
>   While running with 'usb-handoff' turned on, do you see something like
> "EHCI early BIOS handoff failed" (in power on or reboot cases) ? 
Nope,
		nothing of the like in the serial console log.

Regards,
		Boris.

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
