Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266470AbUBQTCb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266481AbUBQTCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:02:30 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:44516 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S266470AbUBQTCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:02:22 -0500
Date: Tue, 17 Feb 2004 19:45:43 +0100
From: GCS <gcs@lsc.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc4
Message-ID: <20040217184543.GA18495@lsc.hu>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Feb 16, 2004 at 07:51:08PM -0800, Linus Torvalds <torvalds@osdl.org> wrote:
>  I'm planning on doing the final 2.6.3 tomorrow, so please test this 
> final -rc.
> 
> Most notably, this should support ppc/ppc64 out-of-the-box, complete with
> G5 support (64-bit). Special thanks to BenH who made sure the new radeonfb
> driver works on a wide variety of hardware (a number of the fixes here
> relative to -rc3 was making sure the driver works on regular x86 laptops).
 For me on a laptop with integrated Radeon Mobility card:
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0xb2a03): In function `radeon_setup_i2c_bus':
: undefined reference to `i2c_bit_add_bus'
drivers/built-in.o(.text+0xb2b7a): In function `radeon_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0xb2b8a): In function `radeon_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0xb2b9a): In function `radeon_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0xb2baa): In function `radeon_delete_i2c_busses':
: undefined reference to `i2c_bit_del_bus'
drivers/built-in.o(.text+0xb2c44): In function `radeon_do_probe_i2c_edid':
: undefined reference to `i2c_transfer'
make: *** [.tmp_vmlinux1] Error 1

.config snippshet:
# CONFIG_FB_RADEON_OLD is not set
CONFIG_FB_RADEON=y
CONFIG_FB_RADEON_I2C=y
CONFIG_FB_RADEON_DEBUG=y
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set

Distribution: Debian Sid, gcc is gcc version 3.3.3 20040214 (prerelease)
(Debian)

AFAICR -rc3 was the first version with this problem.

Cheers,
GCS
