Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269364AbUJRDsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269364AbUJRDsV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 23:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269370AbUJRDsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 23:48:21 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:60535 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269364AbUJRDsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 23:48:20 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alexandre Oliva <aoliva@redhat.com>
Subject: Re: forcing PS/2 USB emulation off
Date: Sun, 17 Oct 2004 22:48:16 -0500
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br>
In-Reply-To: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200410172248.16571.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 October 2004 02:34 pm, Alexandre Oliva wrote:
> To get the touchpad to work on my Compaq Presario r3004 notebook, in
> addition to ALPS Touchpad patches by Dmitry Torokhov, I needed a patch
> by Vojtech Pavlik that disabled PS/2 USB emulation early in the boot.
> The BIOS didn't have an option to disable it, and, without it, PS/2
> mouse detection wouldn't find anything and, if psmouse is built into
> the kernel, as it happens to be the case for Fedora Core kernels,
> there's no way to re-probe.

Actually, now there is. Starting with 2.6.9 it is possible to force
either rescan or reconnect for devices connected to serio ports:

	echo -n "reconnect"  > /sys/bus/serio/devices/serio1/driver

should cause re-probe. Just FYI. As Greg said the USB handoff patch
is in -mm three and should take care of most of the issues.

BTW, I think that handoff should be activated by default. I am lurking
in Gentoo forums and there are coultless people having problems with
their mice/touchpads detected properly unless they load their USB drivers
first.

-- 
Dmitry
