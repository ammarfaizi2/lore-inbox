Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316724AbSEVUPx>; Wed, 22 May 2002 16:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316726AbSEVUPw>; Wed, 22 May 2002 16:15:52 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:41221 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316724AbSEVUPv>;
	Wed, 22 May 2002 16:15:51 -0400
Date: Wed, 22 May 2002 13:15:46 -0700
From: Greg KH <greg@kroah.com>
To: Andre Bonin <kernel@bonin.ca>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Linux-usb-users@lists.sourceforge.net
Subject: Re: What to do with all of the USB UHCI drivers in the kernel?
Message-ID: <20020522201546.GB5168@kroah.com>
In-Reply-To: <20020520223132.GC25541@kroah.com> <008b01c2012d$69db21c0$0601a8c0@CHERLYN> <20020522192101.GG4802@kroah.com> <3CEBF314.3090209@bonin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Wed, 24 Apr 2002 18:36:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 03:35:48PM -0400, Andre Bonin wrote:
> >This is probably because you have an OHCI hardware device, not a UHCI
> >device.  What does 'lspci -v' say for your machine?
> 
> Sorry, i'me not too familiar with the USB architecture.  Anyway here is 
> the relevant lspci entries (note: I did this under my working 2.4.18)
> 
> 02:08.0 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
>         Subsystem: Unknown device 807d:0035
>         Flags: bus master, medium devsel, latency 32, IRQ 19
>         Memory at cd000000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [40] Power Management version 2
> 
> 02:08.1 USB Controller: NEC Corporation USB (rev 41) (prog-if 10 [OHCI])
>         Subsystem: Unknown device 807d:0035
>         Flags: bus master, medium devsel, latency 32, IRQ 16
>         Memory at cc800000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [40] Power Management version 2
> 
> 02:08.2 USB Controller: NEC Corporation USB 2.0 (rev 02) (prog-if 20 [EHCI])
>         Subsystem: Unknown device 807d:1043
>         Flags: bus master, medium devsel, latency 32, IRQ 17
>         Memory at cc000000 (32-bit, non-prefetchable) [size=256]
>         Capabilities: [40] Power Management version 2

You only have EHCI and OHCI hardware.  No wonder the UHCI drivers do not
work :)

> >And how does 2.5.17 work for you?
> 
> Not too good beacuse I don't have the option of enabling OHCI :)  Are we 
> still keeping it?

Yes, use the ohci-hcd driver.  Also you can use the ehci-hcd driver if
you have any USB 2.0 devices, as it looks like you have a USB 2.0
controller.

thanks,

greg k-h
