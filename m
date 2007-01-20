Return-Path: <linux-kernel-owner+w=401wt.eu-S1750896AbXATXJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbXATXJy (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 18:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbXATXJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 18:09:54 -0500
Received: from twin.jikos.cz ([213.151.79.26]:58683 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbXATXJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 18:09:53 -0500
Date: Sun, 21 Jan 2007 00:09:48 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Ivan Ukhov <uvsoft@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to use an usb interface than is claimed by HID?
In-Reply-To: <45B265E0.5020605@gmail.com>
Message-ID: <Pine.LNX.4.64.0701210006591.21127@twin.jikos.cz>
References: <45B265E0.5020605@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2007, Ivan Ukhov wrote:

> I'm writing a driver for an USB device that has one configuration with 
> several interfacies and one of them is a HID interface. So when I check 
> this interface whether it's claimed (usb_interface_claimed), I find out 
> that it is, and it's claimed by the HID driver. So here is the question: 
> how can I ask the HID driver to unclaim this very interface for me so 
> that I can use it? The HID driver is needed for some other devices, so I 
> can't just rmmod it.

Hi Ivan,

if I understand correctly what you need, wouldn't setting the 
HID_QUIRK_IGNORE for a given tuple of idVendor and idProduct be enough? 
(see hid_blacklist[] in drivers/usb/input/hid-core.c).

-- 
Jiri Kosina
