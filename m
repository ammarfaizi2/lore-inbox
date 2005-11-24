Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVKXKyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVKXKyH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 05:54:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbVKXKyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 05:54:07 -0500
Received: from styx.suse.cz ([82.119.242.94]:56512 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751360AbVKXKyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 05:54:06 -0500
Date: Thu, 24 Nov 2005 11:53:52 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Vishal Linux <vishal.linux@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to get SDA/SCL bit position in the control word register of the video card?
Message-ID: <20051124105352.GA31195@midnight.suse.cz>
References: <e3e24c6a0511240245i1d395ae6g4d768a75a602d6ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3e24c6a0511240245i1d395ae6g4d768a75a602d6ce@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 10:45:14AM +0000, Vishal Linux wrote:
> Hello,
> 
> 
> I am trying to communicate to the monitor eeprom to get the monitor
> capabilities and for that i need to have SDA/SCL bit positions in the
> control word register of the video card (to read and wrtie data using
> i2c protocol).
> 
> Different video card vendors have different offsets for the control
> word register and different bit positions for SDA/SCL.
> 
> I tried to use linux kernel API char* get_EDID_from_BIOS(void*) and
> then using kgdb to debug the kernel module (that i wrote) to get the
> same  but failed to find the way to get the above.
> 
> I do have the offset of the control word register and Masking Value of
> Intel and Matrox card but i would like NOT to hardcode the masking
> value and the offset in my code. This will lead me to modify  my code
> for the different cards.
> 
> Is there any way to get the control word register's address (and then
> SDA/SCL bit position) on the linux operating system. Is this
> information available to linux kernel ?
> 
> FYI : Masking Value that i am referring to is the value that has to be
> ANDed to the DATA(bit - 0/1) before writing it to Control word
> register so that the right bit can be written on to the SDA/SCL lines.
> 
> Any pointers to this or your guidance would be highly appreciated.
 
No, it's not possible. That's why Linux has to resort to using the BIOS
for this - only the specific BIOS knows how the manufacturer wired the
card.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
