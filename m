Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSLAAe7>; Sat, 30 Nov 2002 19:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261353AbSLAAe6>; Sat, 30 Nov 2002 19:34:58 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:43660
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261349AbSLAAe6>; Sat, 30 Nov 2002 19:34:58 -0500
Date: Sat, 30 Nov 2002 19:45:28 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [CFT] Serial double initialisation
In-Reply-To: <20021130235031.C30365@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.50.0211301915560.1628-100000@montezuma.mastecende.com>
References: <20021130235031.C30365@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Nov 2002, Russell King wrote:

> A while ago, Alan reported to me a double-initialisation bug between the
> ISA init and PNP initialisation of serial ports.
>
> Since then, Alan integrated a patch I sent him into -ac, and as yet I
> haven't heard any feedback.  Since I don't have the PNP hardware to be
> able to test this, I'm not putting it into Linus' tree until I hear some
> success.
>
> So, if people are using 2.5.50 with PNP support enabled, and if you are
> seeing two "ttyS0" lines during the kernel boot messages, please apply
> this patch and confirm to me that it correctly reports one ttyS0 message.

Thanks for checking this out, the double init only comes when you have
CONFIG_PNPBIOS enabled, but CONFIG_ISAPNP alone is fine. I tested the
patch with both and it does indeed fix the problem.

Cheers,
	Zwane

-- 
function.linuxpower.ca
