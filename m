Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266911AbSKLO0U>; Tue, 12 Nov 2002 09:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266913AbSKLO0U>; Tue, 12 Nov 2002 09:26:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:26118 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266911AbSKLO0T>; Tue, 12 Nov 2002 09:26:19 -0500
Date: Tue, 12 Nov 2002 14:33:06 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 serial driver bug with asus pr-dls m/b
Message-ID: <20021112143306.A14369@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Walrond <andrew@walrond.org>,
	linux-kernel@vger.kernel.org
References: <3DB84EAB.5020608@walrond.org> <20021103135813.B5589@flint.arm.linux.org.uk> <3DD0E95D.3090801@walrond.org> <3DD0F03F.9000604@walrond.org> <3DD0F987.3050409@walrond.org> <3DD106FA.5060809@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DD106FA.5060809@walrond.org>; from andrew@walrond.org on Tue, Nov 12, 2002 at 01:49:46PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 12, 2002 at 01:49:46PM +0000, Andrew Walrond wrote:
> Further to the hanging serial output; disabling DEBUG_AUTOCONF in 8250.c 
> removes this problem.
> 
> So the only remaining problem is when remote console=ENABLED, rather 
> than post only, in the bios. If this is a problem at all ?
> 
> I assume that remote console=enabled redirects the interrupt 0x10 
> “video” requests used to write to the screen and sends the characters to 
> the serial port instead, rather than just the POST messages. Since the 
> 16bit bios is chucked out when the 32bit linux kernel boots, I don't 
> understand why this upsets anything?

Well, it looks like the serial port at 0x3f8 gets unmapped by the bios
when you set remote console=ENABLED.  The debug output you've sent all
points towards there being no physical port at 0x3f8.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

