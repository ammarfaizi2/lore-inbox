Return-Path: <linux-kernel-owner+w=401wt.eu-S1760037AbWLHTnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760037AbWLHTnM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761153AbWLHTnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:43:12 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:58837 "EHLO
	mail.holtmann.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760037AbWLHTnK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:43:10 -0500
Subject: Re: [GIT PATCH] HID patches for 2.6.19
From: Marcel Holtmann <marcel@holtmann.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       Jiri Kosina <jkosina@suse.cz>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0612081126420.3516@woody.osdl.org>
References: <20061208185419.GA6912@kroah.com>
	 <Pine.LNX.4.64.0612081126420.3516@woody.osdl.org>
Content-Type: text/plain
Date: Fri, 08 Dec 2006 20:38:17 +0100
Message-Id: <1165606697.400.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> > Here are some patches that move the HID code to a new directory allowing
> > it to be used by other kernel subsystems easier.
> 
> I pulled. However, I think the Kconfig changes are HORRIBLE.
> 
> I don't understand why people don't use "select" more. Why should Kconfig 
> ask for "Generic HID support?" That question _never_ makes sense to a 
> user. And if you answer "n", you'll not get USB_HID.
> 
> This is not user-friendly. If you need HID support, just select it. Don't 
> ask people questions that make no sense. If the generic HID code is needed 
> for some driver, you just select it. If it's not needed, you don't. It's 
> that easy.

since we don't have any user-space or out of kernel HID transport
drivers at the moment it would make sense to simply select HID if
someone selects USB_HID or the upcoming Bluetooth transport.

Regards

Marcel


