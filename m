Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275326AbTHGMj2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 08:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275325AbTHGMj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 08:39:28 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:40205 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275324AbTHGMj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 08:39:27 -0400
Date: Thu, 7 Aug 2003 13:39:23 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Stuart Longland <stuartl@longlandclan.hopto.org>
Cc: Linux Lernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problems with Yamaha opl3sa2 under 2.4.20 and ongoing PCMCIA & USB problems on 2.6.0-test2
Message-ID: <20030807133923.A25908@flint.arm.linux.org.uk>
Mail-Followup-To: Stuart Longland <stuartl@longlandclan.hopto.org>,
	Linux Lernel Mailing List <linux-kernel@vger.kernel.org>
References: <3F32417D.3090000@longlandclan.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F32417D.3090000@longlandclan.hopto.org>; from stuartl@longlandclan.hopto.org on Thu, Aug 07, 2003 at 10:09:33PM +1000
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07, 2003 at 10:09:33PM +1000, Stuart Longland wrote:
> Under 2.6.0-test2:
> 	- PCMCIA locks hard when adding and removing PCMCIA cards, even if I
> run 'cardctl eject' first.

This may be due to the screwups in the TI cardbus bridge code.
2.6.0-test2-bk<whatever-last-night-was> should have these problems
solved.

> 	- My combo network card & modem "Xircom RealPort Ethernet 10/100+Modem
> 56" only partially works.  Network works if I load 8250_cs, but
> otherwise, the pcmcia-cs utilities try loading serial_cs.

It's not clear what's wrong here.  Add into /etc/modprobe.conf an
alias for serial_cs to 8250_cs and everything should work.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

