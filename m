Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVAOLEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVAOLEd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 06:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVAOLEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 06:04:33 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14344 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262253AbVAOLE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 06:04:27 -0500
Date: Sat, 15 Jan 2005 11:04:18 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Karel Kulhavy <clock@twibright.com>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       linux-kernel@vger.kernel.org
Subject: Re: How to hang 2.6.9 using serial port and FB console
Message-ID: <20050115110418.A11150@flint.arm.linux.org.uk>
Mail-Followup-To: Karel Kulhavy <clock@twibright.com>,
	"Dr. David Alan Gilbert" <gilbertd@treblig.org>,
	linux-kernel@vger.kernel.org
References: <20041226143118.GA5169@beton.cybernet.src> <20041226145334.GC1668@gallifrey> <20041226154321.GA5519@beton.cybernet.src> <20041226155350.GD1668@gallifrey> <20041226162107.GB5859@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041226162107.GB5859@beton.cybernet.src>; from clock@twibright.com on Sun, Dec 26, 2004 at 04:21:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2004 at 04:21:07PM +0000, Karel Kulhavy wrote:
> However it is not sending breaks, but rather various characters. As the kernel
> seems to be set internally for echo cahracters going into the computer on the
> transmit line again, and the characters are echoed by the infrared receiver
> during transmission too, a character stream cycles infinitely there.
> 
> However kernel shouldn't hang even if you wired the serial input to an alien
> spacecraft.

How do you know if it's the serial that's causing the hang rather than
the virtual console subsystem?

Your original description seems to imply that the machine only hung after
you switched from VC1 to VC3, and then you found you couldn't switch back
to VC1.  To me, that sounds virtual console related rather than serial
related.  Especially if you can reproduce it at this exact point in time
every time.

Have you tried sysrq-p or sysrq-t to get a trace/thread info from the
kernel?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
