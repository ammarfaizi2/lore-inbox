Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135193AbRDZIcP>; Thu, 26 Apr 2001 04:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135198AbRDZIcF>; Thu, 26 Apr 2001 04:32:05 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:2432 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S135193AbRDZIbx>;
	Thu, 26 Apr 2001 04:31:53 -0400
Date: Thu, 26 Apr 2001 10:05:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vivek Dasmohapatra <vivek@etla.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: drivers/usb/hid.c
Message-ID: <20010426100547.A1659@suse.cz>
In-Reply-To: <Pine.LNX.4.10.10104252235460.2687-100000@www.teaparty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10104252235460.2687-100000@www.teaparty.net>; from vivek@etla.org on Wed, Apr 25, 2001 at 10:44:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2001 at 10:44:37PM +0100, Vivek Dasmohapatra wrote:
> 
> Hi: Been battling w. my new Gravis joystick [kernel 2.4.3-ac5] - the
> driver wouldn't recognise it through the gameport, but would through the
> USB port [the stick came with a converter]. I did have one problem though:
> I had to apply the following one line patch to get the joystick hat to
> work correctly: Don't know if this is generally correct, as I only have
> one USB joystick with which to test it.
> 
> --- linux/drivers/usb/hid.c~	Sat Apr 21 20:34:33 2001
> +++ linux/drivers/usb/hid.c	Sat Apr 21 20:38:51 2001
> @@ -78,7 +78,7 @@
>  static struct {
>  	__s32 x;
>  	__s32 y;
> -}  hid_hat_to_axis[] = {{ 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}, { 0, 0}};
> +}  hid_hat_to_axis[] = {{ 0, 0}, { 0,-1}, { 1,-1}, { 1, 0}, { 1, 1}, { 0, 1}, {-1, 1}, {-1, 0}, {-1,-1}};
>  
>  static char *hid_types[] = {"Device", "Pointer", "Mouse", "Device", "Joystick",
>  				"Gamepad", "Keyboard", "Keypad", "Multi-Axis Controller"};

I'll have to verify, but either a fix got lost somewhere, or this is a
bug in the joystick. The hats were working fine.

-- 
Vojtech Pavlik
SuSE Labs
