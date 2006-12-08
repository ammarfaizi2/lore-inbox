Return-Path: <linux-kernel-owner+w=401wt.eu-S968835AbWLHT3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968835AbWLHT3W (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968836AbWLHT3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:29:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:53081 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968835AbWLHT3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:29:22 -0500
Date: Fri, 8 Dec 2006 11:28:57 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Greg KH <gregkh@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Jiri Kosina <jkosina@suse.cz>,
       Marcel Holtmann <marcel@holtmann.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: [GIT PATCH] HID patches for 2.6.19
In-Reply-To: <20061208185419.GA6912@kroah.com>
Message-ID: <Pine.LNX.4.64.0612081126420.3516@woody.osdl.org>
References: <20061208185419.GA6912@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Dec 2006, Greg KH wrote:
>
> Here are some patches that move the HID code to a new directory allowing
> it to be used by other kernel subsystems easier.

I pulled. However, I think the Kconfig changes are HORRIBLE.

I don't understand why people don't use "select" more. Why should Kconfig 
ask for "Generic HID support?" That question _never_ makes sense to a 
user. And if you answer "n", you'll not get USB_HID.

This is not user-friendly. If you need HID support, just select it. Don't 
ask people questions that make no sense. If the generic HID code is needed 
for some driver, you just select it. If it's not needed, you don't. It's 
that easy.

		Linus
