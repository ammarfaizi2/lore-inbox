Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbUAYIoS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 03:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUAYIoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 03:44:18 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:11648 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263805AbUAYIoR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 03:44:17 -0500
Date: Sun, 25 Jan 2004 09:44:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: rvalles <rvalles@es.gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: joydev: kernel panic accessing /dev/js0 with 2.6.2-rc1-bk1
Message-ID: <20040125084425.GA610@ucw.cz>
References: <20040125060731.GA5797@217-126-33-148.uc.nombres.ttd.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125060731.GA5797@217-126-33-148.uc.nombres.ttd.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 25, 2004 at 07:07:31AM +0100, rvalles wrote:
> > If you also could get the function where EIP is, that'd be great.
> Oops! Did I really post all the stack trace and forgot about the current
> function? Well, I wonder what was I thinking. Here it is:
> 
> EIP is at hidinput_hid_event+0x8f/0x2a0
> 
> Also, had to boot from a Knoppix 3.3 for some stuff, and verified, with jstest,
> that the pad seems to be working well with its kernel (2.4.22-xfs).
> 
> I also forgot to tell you that I've got CONFIG_HID_FF and CONFIG_LOGITECH_FF
> enabled on my 2.6.2-rc1-bk1.
> 
> cc me on reply. I'm not suscribed into linux-kernel.

Ok, now I see how and where it happens. But I need the device HID
desriptor dump. Please enable DEBUG and DEBUG_DATA in hid-core.c,
and send me the output it produces into 'dmesg'. If you want to avoid
the crash, simply disable hid-input in kernel config for the experiment.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
