Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263549AbTDMQjY (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 12:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263550AbTDMQjY (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 12:39:24 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:16652 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263549AbTDMQjX (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 12:39:23 -0400
Date: Sun, 13 Apr 2003 17:51:04 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: jt@hpl.hp.com
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: uart_ioctl OOPS with irtty-sir
Message-ID: <20030413175104.A15846@flint.arm.linux.org.uk>
Mail-Followup-To: jt@hpl.hp.com,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20030404013405.GA19446@bougret.hpl.hp.com> <20030404102535.A29313@flint.arm.linux.org.uk> <20030408174443.GA23935@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030408174443.GA23935@bougret.hpl.hp.com>; from jt@bougret.hpl.hp.com on Tue, Apr 08, 2003 at 10:44:43AM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 10:44:43AM -0700, Jean Tourrilhes wrote:
> 	I was tempted to create the same API for setting the speed
> (baud rate), but that may need to wait for another time.

I'm not intending changing the settermios API - it would be rather
inefficient to have a set of "set baud rate", "set stop bits",
"set bits per character", "set parity error response" etc calls,
especially when many of these involve writing the same set of
registers in the UART.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

