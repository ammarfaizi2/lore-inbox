Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbWFUTCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbWFUTCs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 15:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWFUTCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 15:02:47 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:24082 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932642AbWFUTCq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 15:02:46 -0400
Date: Wed, 21 Jun 2006 15:02:44 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: andi@lisas.de
cc: Bodo Eggert <7eggert@gmx.de>, Andrew Morton <akpm@osdl.org>,
       <linux-usb-devel@lists.sourceforge.net>, <gregkh@suse.de>,
       <linux-kernel@vger.kernel.org>, <hal@lists.freedesktop.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner
 underruns, USB HDD hard resets)
In-Reply-To: <20060621163410.GA22736@rhlx01.fht-esslingen.de>
Message-ID: <Pine.LNX.4.44L0.0606211501290.8272-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Andreas Mohr wrote:

> Maybe it's better to (additionally?) go down the route of fixing up
> low-level communication weaknesses (since it's been semi-confirmed that it's
> an USB communication issue, see other thread part).
> IMHO this is a severe user experience issue that shouldn't be fixed up
> ("covered", "hidden") by the O_EXCL thingy alone.

It's not a USB issue; it's a matter of lack of coordination between the sg 
and sr drivers.  Each is unaware of the actions of the other, even when 
they are speaking to the same device.

Alan Stern

