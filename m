Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266905AbUAXKzF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 05:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266907AbUAXKzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 05:55:05 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:6017 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S266905AbUAXKzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 05:55:00 -0500
Date: Sat, 24 Jan 2004 11:55:06 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: rvalles <rvalles@es.gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: joydev: kernel panic accessing /dev/js0 with 2.6.2-rc1-bk1
Message-ID: <20040124105506.GB9282@ucw.cz>
References: <20040124090354.GA5285@217-126-33-148.uc.nombres.ttd.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040124090354.GA5285@217-126-33-148.uc.nombres.ttd.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 24, 2004 at 10:03:54AM +0100, rvalles wrote:

> I got a new USB gamepad called "Logitech WingMan RumblePad".
> 
> I had USB with UHCI HCD working on 2.6.1, for my mouse (USB full HID) on
> kernel (not as a module). But I didn't have joystick support, so I got myself
> 2.6.2-rc1-bk1 and built it, with Joystick Interface as a module.
> 
> Then, I do:
> # modprobe joydev
> # cat /dev/js0
> 
> and I get:
> DIVIDE ERROR:0000[#1]
> 
> Calltrace:
> hid_process_event
> hid_input_field
> add_timer_randomness
> hid_input_report
> hid_irq_in
> usb_hcd_irq
> handle_IRQ_event
> do_IRQ
> rest_init
> common_interrupt
> rest_init
> <...>
> 
> Kernel Panic: Fatal exception in interrupt
> 
> I've shortened a lot of detail, through, because I had to copy it by hand. I
> hope it's enough to debug it. Tell me otherwise, and I'll copy the needed
> stuff.

If you also could get the function where EIP is, that'd be great.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
