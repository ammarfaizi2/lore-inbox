Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756200AbWKRHQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200AbWKRHQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 02:16:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756204AbWKRHQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 02:16:26 -0500
Received: from raven.upol.cz ([158.194.120.4]:36002 "EHLO raven.upol.cz")
	by vger.kernel.org with ESMTP id S1756200AbWKRHQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 02:16:25 -0500
Date: Sat, 18 Nov 2006 07:22:59 +0000
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       vgoyal@in.ibm.com, akpm@osdl.org, rjw@sisk.pl, ebiederm@xmission.com,
       Reloc Kernel List <fastboot@lists.osdl.org>, pavel@suse.cz,
       magnus.damm@gmail.com
Subject: Re: [PATCH 20/20] x86_64: Move CPU verification code to common file
Message-ID: <20061118072259.GC14673@flower.upol.cz>
References: <20061117223432.GA15449@in.ibm.com> <20061117225953.GU15449@in.ibm.com> <slrnelt6h7.dd3.olecom@flower.upol.cz> <20061118063802.GE30547@bingen.suse.de> <20061118070101.GA14673@flower.upol.cz> <455EAF54.5090500@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <455EAF54.5090500@zytor.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
From: Oleg Verych <olecom@flower.upol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2006 at 10:59:32PM -0800, H. Peter Anvin wrote:
> Oleg Verych wrote:
> >
> >It will burn CPU, until power cycle will be done (my AMD64 laptop and
> >Intel's amd64 destop PC require that). In case of reboot timeout (or
> >just reboot with jump to BIOS), i will just choose another image to boot
> >or will press F8 to have another boot device.
> >
> 
> That's a fairly stupid argument, since it assumes operator intervention, 
> at which point you have access to the machine anyway.

I would never call *power cycle* stupid, just because from physics
point of veiw.

Example. I have my flower.upol.cz many kilometers far away from me.
I used to boot it from that flash (new hardware, sata problems, etc).

When something goes wrong with rc kernel or power source, bum.
And i had to move my ass there, just to press reset. Because.

While i have "power on, on AC failures" in BIOS, *sometimes* flash
will not boot (i don't know why, maybe it's GRUB+flash-read,
or BIOS usb hdd implementation specific).

DTR laptop ~33% doesn't boot that flash. And laptop has no reset button.
Operator is present, so your consern is right here.

> A stronger argument is, again, that some bootloaders can do unattended 
> fallback.
____

