Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVA0AZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVA0AZx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 19:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVA0AYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 19:24:44 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:11758 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262190AbVAZX4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 18:56:47 -0500
Date: Thu, 27 Jan 2005 00:57:37 +0100
From: DervishD <lkml@dervishd.net>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Oliver Neukum <oliver@neukum.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
Subject: Re: [Linux-usb-users] Re: USB API, ioctl's and libusb
Message-ID: <20050126235737.GA305@DervishD>
Mail-Followup-To: Alan Stern <stern@rowland.harvard.edu>,
	Oliver Neukum <oliver@neukum.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
References: <20050126163811.GA259@DervishD> <Pine.LNX.4.44L0.0501261711150.639-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44L0.0501261711150.639-100000@ida.rowland.org>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Alan :)
 * Alan Stern <stern@rowland.harvard.edu> dixit:
> >     BTW, and judging from the program I've read, there are lots of
> > operations that must be done using 'usb_control_msg', and libusb
> > implements that function with exactly the same interface as the
> > kernel. The only difference is that libusb uses ioctl and the kernel
> > implements the function using URB's. IMHO libusb doesn't provide a
> > cleaner API, the only advantage of libusb is portability. Anyway,
> > I've not used it enough to judge, I'm more concerned about kernel USB
> > interface, not libusb one.
> You don't seem to understand the difference between a kernel API and a
> user API.  Only code that is part of the kernel can use a kernel API, so
> only kernel drivers can use the "URB" interface.  By contrast, a user API
> can be used by regular programs, not part of the kernel.  libusb provides
> a user API.

    I thought that <linux/usb.h> provided a user API, not a kernel
one. In fact I thought that the functions provided throught that
header were syscalls. They are not, I've checked ;)

> So there's really no choice.  Unless you're writing a kernel module, your 
> program can't use URBs.  You can use libusb, or if you don't care about 
> portability you can use ioctl calls directly.  But you can't use URBs.

    OK, that's right. I really thought that there were syscalls
providing USB API for user space programs. That sounded less weird
when I first thought of it ;)) Thanks for the help :)))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
