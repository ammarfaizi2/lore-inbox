Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316753AbSEWOso>; Thu, 23 May 2002 10:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316754AbSEWOsn>; Thu, 23 May 2002 10:48:43 -0400
Received: from DHCP-89-51.SLAC.Stanford.EDU ([134.79.89.51]:36485 "EHLO
	router-273.sgowdy.org") by vger.kernel.org with ESMTP
	id <S316753AbSEWOsl>; Thu, 23 May 2002 10:48:41 -0400
Date: Thu, 23 May 2002 07:48:20 -0700 (PDT)
From: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
X-X-Sender: gowdy@router-273.sgowdy.org
Reply-To: gowdy@slac.stanford.edu
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: Greg KH <greg@kroah.com>, Andre Bonin <kernel@bonin.ca>,
        <linux-usb-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>,
        <Linux-usb-users@lists.sourceforge.net>
Subject: Re: [Linux-usb-users] Re: What to do with all of the USB UHCI drivers
 in the kernel?
In-Reply-To: <3CEC8D6B.9060500@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0205230746500.1824-100000@router-273.sgowdy.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,
	What do you actually want to know? That an EHCI controller should 
use the ehci-hcd driver and that the OHCI controller should use the 
ohci-hcd controller? Or that the uhci-* drivers can't drive a EHCI or OHCI 
controller? Or something else?

							rgeards,

							Stephen.

On Thu, 23 May 2002, Martin Dalecki wrote:

> Uz.ytkownik Greg KH napisa?:
> > On Wed, May 22, 2002 at 03:35:48PM -0400, Andre Bonin wrote:
> > 
> >>>This is probably because you have an OHCI hardware device, not a UHCI
> >>>device.  What does 'lspci -v' say for your machine?
> >>
> >>Sorry, i'me not too familiar with the USB architecture.  Anyway here is 
> >>the relevant lspci entries (note: I did this under my working 2.4.18)
> >>
> >>02:08.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
> >>        Subsystem: Unknown device 807d:0035
> >>        Flags: bus master, medium devsel, latency 32, IRQ 19
> >>        Memory at cd000000 (32-bit, non-prefetchable) [size=4K]
> >>        Capabilities: [40] Power Management version 2
> >>
> >>02:08.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
> >>        Subsystem: Unknown device 807d:0035
> >>        Flags: bus master, medium devsel, latency 32, IRQ 16
> >>        Memory at cc800000 (32-bit, non-prefetchable) [size=4K]
> >>        Capabilities: [40] Power Management version 2
> >>
> >>02:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
> >>        Subsystem: Unknown device 807d:1043
> >>        Flags: bus master, medium devsel, latency 32, IRQ 17
> >>        Memory at cc000000 (32-bit, non-prefetchable) [size=256]
> >>        Capabilities: [40] Power Management version 2
> > 
> > 
> > You only have EHCI and OHCI hardware.  No wonder the UHCI drivers do not
> > work :)
> > 
> > 
> >>>And how does 2.5.17 work for you?
> >>
> >>Not too good beacuse I don't have the option of enabling OHCI :)  Are we 
> >>still keeping it?
> > 
> > 
> > Yes, use the ohci-hcd driver.  Also you can use the ehci-hcd driver if
> > you have any USB 2.0 devices, as it looks like you have a USB 2.0
> > controller.
> 
> 
> Could you please just do me a small favour and drop something
> in to linux/Documentation. Becouse I'm right now already confused
> about which driver to use and which alias to put in /etc/modules.conf
> so kudzu stops hollering about not knowing what to do
> if I out of a sudden reboot in to 2.5.xx kernel.
> 
> Many thank's in advance.
> 
> PS. I could of course figure it out of my self, but since
> I don't attach anything to USB on my box *that* frequently.
> 
> 
> 
> _______________________________________________________________
> 
> Don't miss the 2002 Sprint PCS Application Developer's Conference
> August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
> 
> _______________________________________________
> Linux-usb-users@lists.sourceforge.net
> To unsubscribe, use the last form field at:
> https://lists.sourceforge.net/lists/listinfo/linux-usb-users
> 

-- 
 /------------------------------------+-------------------------\
|Stephen J. Gowdy                     | SLAC, MailStop 34,       |
|http://www.slac.stanford.edu/~gowdy/ | 2575 Sand Hill Road,     |
|http://calendar.yahoo.com/gowdy      | Menlo Park CA 94025, USA |
|EMail: gowdy@slac.stanford.edu       | Tel: +1 650 926 3144     |
 \------------------------------------+-------------------------/

