Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSKXTJt>; Sun, 24 Nov 2002 14:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSKXTJt>; Sun, 24 Nov 2002 14:09:49 -0500
Received: from ppp-1-24.lond-a-4.access.uk.tiscali.com ([80.225.221.24]:43012
	"EHLO caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261587AbSKXTJt>; Sun, 24 Nov 2002 14:09:49 -0500
Date: Sun, 24 Nov 2002 18:07:20 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Kronos <kronos@kronoz.cjb.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.49] Serial registered twice
Message-ID: <20021124180720.A30521@flint.arm.linux.org.uk>
Mail-Followup-To: Kronos <kronos@kronoz.cjb.net>,
	linux-kernel@vger.kernel.org
References: <20021124153842.GA586@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021124153842.GA586@dreamland.darkstar.lan>; from kronos@kronoz.cjb.net on Sun, Nov 24, 2002 at 04:38:42PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2002 at 04:38:42PM +0100, Kronos wrote:
> In my bootlog I see this:
> 
> Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing enabled
> tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
> tts/1 at I/O 0x2f8 (irq = 3) is a 16550A
> pnp: the driver 'serial' has been registered
> pnp: pnp: match found with the PnP device '00:0c' and the driver 'serial'
> devfs_register(tts/0): could not append to parent, err: -17
> tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
> pnp: pnp: match found with the PnP device '00:10' and the driver 'serial'
> devfs_register(tts/1): could not append to parent, err: -17
> tts/1 at I/O 0x2f8 (irq = 3) is a 16550A

Indeed.  Although it is harmless, it isn't what the average user
expects.  I could tweak the serial layer to refuse to re-initialise
an already initalised port.

However, the devfs_regsiter problem is one that needs solving.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

