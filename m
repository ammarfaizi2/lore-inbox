Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269198AbUI2XpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269198AbUI2XpP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269196AbUI2XpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:45:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:33935 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269198AbUI2XpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:45:09 -0400
Date: Wed, 29 Sep 2004 16:38:28 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: patrakov@ums.usu.ru, linux-kernel@vger.kernel.org
Subject: Re: udev is too slow creating devices
Message-Id: <20040929163828.4d06010b.rddunlap@osdl.org>
In-Reply-To: <20040919173035.GA2345@kroah.com>
References: <414C9003.9070707@softhome.net>
	<1095568704.6545.17.camel@gaston>
	<414D42F6.5010609@softhome.net>
	<20040919140034.2257b342.Ballarin.Marc@gmx.de>
	<414D96EF.6030302@softhome.net>
	<20040919171456.0c749cf8.Ballarin.Marc@gmx.de>
	<cikaf1$e60$1@sea.gmane.org>
	<20040919173035.GA2345@kroah.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Sep 2004 10:30:35 -0700 Greg KH wrote:

| On Sun, Sep 19, 2004 at 10:00:52PM +0600, Alexander E. Patrakov wrote:
| > 
| > OK. The fact is that, when mounting the root filesystem, the kernel can 
| > (?) definitely say "there is no such device, and it's useless to wait 
| > for it--so I panic". Is it possible to duplicate this logic in the case 
| > with udev and modprobe? If so, it should be built into a common place 
| > (either the kernel or into modprobe), but not into all apps.
| 
| No, we need to just change the kernel to sit and spin for a while if the
| root partition is not found.  This is the main problem right now for
| booting off of a USB device (or any other "slow" to discover device.)
| It's a known kernel issue, and there are patches for 2.4 for this, but
| no one has taken the time to update them for 2.6.

(I'm way behind, and I was hoping this thread would die, but:)

I've seen 2.6 patches for booting from USB or IEEE1394.
Is there a fair chance of getting something for USB/1394 booting
merged?  (other than by using initrd)

I'd certainly like to see them merged.


[snip]

--
~Randy
MOTD:  Always include version info.
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
