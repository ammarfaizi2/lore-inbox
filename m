Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129776AbQLGTLJ>; Thu, 7 Dec 2000 14:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129778AbQLGTK7>; Thu, 7 Dec 2000 14:10:59 -0500
Received: from quattro.sventech.com ([205.252.248.110]:27916 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S129776AbQLGTKk>; Thu, 7 Dec 2000 14:10:40 -0500
Date: Thu, 7 Dec 2000 13:40:14 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB-related lockup in test12-pre5
Message-ID: <20001207134013.L935@sventech.com>
In-Reply-To: <11659.976180540@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <11659.976180540@redhat.com>; from David Woodhouse on Thu, Dec 07, 2000 at 09:15:40AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2000, David Woodhouse <dwmw2@infradead.org> wrote:
> Haven't tried test12-pre7 yet. Is enabling bus mastering likely to make 
> this magically go away? I doubt it.

Probably not. Enabling bus mastering is the difference between USB
working at all (transfering data to the device) and not working.

> This happened when trying to run excel under wine. Dual Celeron with 
> CONFIG_USB_UHCI.

Could you try the alternate UHCI driver? You may need to disable the
UHCI driver you have configured for the option to become visible.

> >>EIP; c0270c21 <stext_lock+4e6d/8f50>   <=====
> Trace; c01f488e <usb_submit_urb+1e/30>
> Trace; ca8578be <[audio]usbout_completed+7e/c0>
> Trace; c01ffc3e <process_urb+1de/230>
> Trace; c01ffd49 <uhci_interrupt+b9/120>

It looks like you were using USB audio? Could you explain what you were
doing when the oops happened?

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
