Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265380AbSKEX7b>; Tue, 5 Nov 2002 18:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265389AbSKEX7b>; Tue, 5 Nov 2002 18:59:31 -0500
Received: from signup.localnet.com ([207.251.201.46]:52618 "HELO
	smtp.localnet.com") by vger.kernel.org with SMTP id <S265380AbSKEX6q>;
	Tue, 5 Nov 2002 18:58:46 -0500
To: Kevin Corry <corryk@us.ibm.com>
Cc: evms-devel@lists.sourceforge.net, evms-announce@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: EVMS announcement
References: <02110516191004.07074@boiler>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <02110516191004.07074@boiler>
Date: 05 Nov 2002 19:05:08 -0500
Message-ID: <m3iszblg0b.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kevin" == Kevin Corry <corryk@us.ibm.com> writes:

Kevin> However, the drawback to making this switch is losing
Kevin> automatic boot-time volume discovery. Activating EVMS volumes
Kevin> will now require a call to a user-space utility, which will
Kevin> need to be added to the system's init scripts in order to
Kevin> activate the volumes on each boot.

Kevin> In addition, this switch complicates having the root filesystem
Kevin> on an EVMS volume.

Actually, this isn't as much of an issue with 2.5-as-it-will-soon-be.
The initramfs stuff solves the problem for booting, and is exactly
where boot-time discovery should be.

You will need to ensure sufficient integration with hotplug to deal
properly with such things as external devices (usb, 1394, cardbus/
pcmcia, iscsi, docking stations, etc) and media bays.  But this should
be relatively easy, yes?

Without initramfs, I find current evms' in-kernel discovery to be very
beneficial from the end-user standpoint, but early userpsace is clearly
the proper place for boot-time volume discovery just as it is for eg
nfsroot or similar (gfs root, root on iscsi or usb or 1394).

In short, your new plans are the way to go, but do be sure to take
advantage of all the kernel offers or will offer.

-JimC

