Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbVAZQjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbVAZQjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262409AbVAZQjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:39:12 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:30886 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262356AbVAZQhz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:37:55 -0500
Date: Wed, 26 Jan 2005 17:38:11 +0100
From: DervishD <lkml@dervishd.net>
To: Oliver Neukum <oliver@neukum.org>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
Subject: Re: USB API, ioctl's and libusb
Message-ID: <20050126163811.GA259@DervishD>
Mail-Followup-To: Oliver Neukum <oliver@neukum.org>,
	Linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net
References: <20050126122014.GF58@DervishD> <200501261440.38766.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200501261440.38766.oliver@neukum.org>
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

    Hi Oliver :)

 * Oliver Neukum <oliver@neukum.org> dixit:
> Am Mittwoch, 26. Januar 2005 13:20 schrieb DervishD:
> >     My question is: which interface should be used by user space
> > applications, <linux/usb.h> or ioctl's? Is the ioctl interface
> > deprecated in any way? In the "Programming guide for Linux USB Device
> > Drivers", located in http://usb.in.tum.de/usbdoc/, I can't find ioctl
> > interface references :?
> You are supposed to use libusb.

    That's irrelevant, the program I was trying to fix uses libusb.
My question is about the preferred kernel interface, 'cause I don't
know if it's the ioctl one or the URB one (well, I'm calling 'URB'
interface the API that is implemented using URB's inside the kernel).

    BTW, and judging from the program I've read, there are lots of
operations that must be done using 'usb_control_msg', and libusb
implements that function with exactly the same interface as the
kernel. The only difference is that libusb uses ioctl and the kernel
implements the function using URB's. IMHO libusb doesn't provide a
cleaner API, the only advantage of libusb is portability. Anyway,
I've not used it enough to judge, I'm more concerned about kernel USB
interface, not libusb one.

    Thanks anyway :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
