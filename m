Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbVIID1N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbVIID1N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 23:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVIID1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 23:27:13 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:47543 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751392AbVIID1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 23:27:12 -0400
X-ORBL: [69.107.75.50]
Date: Thu, 08 Sep 2005 20:27:09 -0700
From: David Brownell <david-b@pacbell.net>
To: lkml@rtr.ca, gregkh@suse.de
Subject: Re: [linux-usb-devel] Re: [GIT PATCH] USB patches for 2.6.13
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20050908235024.GA8159@kroah.com> <4320F661.2010706@rtr.ca>
In-Reply-To: <4320F661.2010706@rtr.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050909032709.5695DE9DCC@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> Is someone actively working on USB Suspend/Resume support yet?

I've got some patches that need refreshing and splitting-out that
don't seem like 2.6.14 material in the "new world", but maybe a
few of them are.

There are also a handful of EHCI and OHCI fixes pending for 2.6.14
which aren't in Greg's latest batch, some of which affect USB PM.
I understand they'll get into the MM tree soon.


> I ask because this is becoming more and more important as people
> shift more to portable notebook computers with Linux.
>
> Enabling CONFIG_USB_SUSPEND is currently a surefire way to
> guarantee crashing my own notebook on suspend/resume,
> whereas it *usually* (but not always) survives when that
> config option is left unset.

That's strange.  For me it's been closer to the other way around,
except that things never crash for me.  Something tells me your
hardware and/or BIOS is different...

Some of the PM and usbcore changes have been tweaking assumptions;
which of course makes some of the more sensitive code paths unhappy.


> Nothing complicated in the configuration -- just a USB mouse,
> but that's enough to nuke it.
>
> Anyone looking at that stuff right now?

I don't know that anyone's looking specifically at the issue that
the HID (mouse) driver has; I'm not.

If your system behaves OK without that mouse connected, it ought
to be easy to fix that one bug.  If not, forward details to
linux-usb-devel (separate thread).

- Dave

