Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290216AbSBORBe>; Fri, 15 Feb 2002 12:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290228AbSBORBW>; Fri, 15 Feb 2002 12:01:22 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:12048
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S290216AbSBORBO>; Fri, 15 Feb 2002 12:01:14 -0500
Date: Fri, 15 Feb 2002 11:35:52 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jean-Luc Leger <reiga@dspnet.fr.eu.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: CML2-2.3.0 is available
Message-ID: <20020215113552.A7351@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jean-Luc Leger <reiga@dspnet.fr.eu.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020214193329.A23463@thyrsus.com> <20020215042631.A23535@zalem.nrockv01.md.comcast.net> <20020215090624.B3047@thyrsus.com> <20020215173504.B85139@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020215173504.B85139@dspnet.fr.eu.org>; from reiga@dspnet.fr.eu.org on Fri, Feb 15, 2002 at 05:35:04PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Luc Leger <reiga@dspnet.fr.eu.org>:
> On Fri, Feb 15, 2002 at 09:06:24AM -0500, Eric S. Raymond wrote:
> > Symbol type is inferred from use in a menu.
> 
> what about those "legend" symbols that were in menus list but with
> no menu declaration ?
> 
> ex:
> menu usb        # USB? support
>         USB_DEBUG
>         usb_options_legend
>         USB_DEVICEFS USB_BANDWIDTH USB_LONG_TIMEOUT
>         usb_controllers_legend
>         h:USB_UHCI? h:USB_UHCI_ALT? h:USB_OHCI?
> ...
> 
> I see no difference in use for usb_options_legend and USB_DEBUG.

Good catch!  Messages had been temporarily disabled, but I finished 
adding a message declaration suffix (!) just before your mail came in.
In 2.3.1 your example will look like this.

menu usb        # USB? support
         USB_DEBUG
         usb_options_legend!
         USB_DEVICEFS USB_BANDWIDTH USB_LONG_TIMEOUT
         usb_controllers_legend!
         h:USB_UHCI? h:USB_UHCI_ALT? h:USB_OHCI?
 ...

The reason for this change in design is to make it easier to automatically
generate per-directory distributed symbols files.  But the good thing about
it is that it simplifies the language -- I was able to remove three constructs
and only have to add back one.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
