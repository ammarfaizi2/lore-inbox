Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267204AbSKXLf6>; Sun, 24 Nov 2002 06:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbSKXLf6>; Sun, 24 Nov 2002 06:35:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51471 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267204AbSKXLf5>; Sun, 24 Nov 2002 06:35:57 -0500
Date: Sun, 24 Nov 2002 11:43:07 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: =?iso-8859-1?Q?Pavel_Jan=EDk?= <Pavel@Janik.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCI serial card with PCI 9052?
Message-ID: <20021124114307.A25408@flint.arm.linux.org.uk>
Mail-Followup-To: =?iso-8859-1?Q?Pavel_Jan=EDk?= <Pavel@Janik.cz>,
	linux-kernel@vger.kernel.org
References: <m3smxx1aaf.fsf@Janik.cz> <20021120095618.GB319@pazke.ipt> <m3fztrcinh.fsf@Janik.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m3fztrcinh.fsf@Janik.cz>; from Pavel@Janik.cz on Sun, Nov 24, 2002 at 12:27:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 24, 2002 at 12:27:14PM +0100, Pavel Janík wrote:
> I have tried to cat /dev/ttyS5 after
> 
> setserial /dev/ttyS5 port 0xd800 irq 11

I think you actually want:

setserial /dev/ttyS5 port 0xd800 irq 11 autoconfig

and then cat /proc/tty/driver/serial and see if the 5: line has changed
from uart:unknown.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

