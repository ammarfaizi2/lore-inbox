Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264073AbUFCRIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264073AbUFCRIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263325AbUFCRIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:08:11 -0400
Received: from palrel12.hp.com ([156.153.255.237]:34494 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264373AbUFCRHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:07:47 -0400
Date: Thu, 3 Jun 2004 10:07:45 -0700
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Jouni Malinen <jkmaline@cc.hut.fi>,
       "Luis R. Rodriguez" <mcgrof@studorgs.rutgers.edu>,
       Netdev <netdev@oss.sgi.com>, hostap@shmoo.com,
       prism54-devel@prism54.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Prism54 WPA Support - wpa_supplicant - Linux general wpa support
Message-ID: <20040603170745.GD8770@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040602071449.GJ10723@ruslug.rutgers.edu> <20040602132313.GB7341@jm.kir.nu> <40BEA3CB.60908@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40BEA3CB.60908@pobox.com>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 12:06:35AM -0400, Jeff Garzik wrote:
> 
> One of the things that is nice about wireless-2.6 is that is affords the 
> opportunity to totally rethink the wireless extensions.
> 
> Although a lot of people would howl, since HostAP is essentially new 
> code from the mainline kernel perspective, a new userland API (and new 
> or updated tools) could come along with it.
> 
> I have mentioned in the past (no offense Jean!) that I do not like the 
> overly-generic wireless handler structure.  It is less type-safe than is 
> generally preferred in Linux, IMO.
> 
> A low-level wireless driver should not implement ioctls, it should 
> implement callbacks in some sort of 'struct wireless_operations' as is 
> done in other kernel subsystems.
> 
> ioctl details should be hidden from low-level drivers as much as 
> possible, through type-safe interfaces.  Strive to make both the 
> wireless driver API and the wireless userland API easy to change and 
> evolve over time.
> 
> 	Jeff

	Jeff, I'm amazed that you are so obsessed with this. Yes,
Wireless Extension could be improved in millions ways, but at least
it's working, whereas there are so many other areas where we have
nothing at all. If you talk with most people developping wireless
drivers, this doesn't even make their list. But I guess every one of
us need to have his hot topic ;-)

	I believe most people are concerned about :
	o WPA support (and security API in general)
	o SNAP encapsulation/decapsualtion in kernel
	o handling 802.11 frames natively in kernel
	o handling 802.11 management in kernel (association/deassociation, ...)

	Personally, those are my priorities :
	o getting more wireless drivers in the kernel
	o RtNetlink API for Wireless Extensions

	I also explained you how you could wrap around Wireless
Extension trivially to introduce a new driver API without breaking the
many user space tools, so that you can implement your proposal with
maximum backward compatibility. Just because there is one aspect of
the API you don't like, we don't need to throw away the good parts.

	Have fun...

	Jean
