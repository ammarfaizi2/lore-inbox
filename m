Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317166AbSFKQf2>; Tue, 11 Jun 2002 12:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSFKQf1>; Tue, 11 Jun 2002 12:35:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47632 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317166AbSFKQf1>; Tue, 11 Jun 2002 12:35:27 -0400
Date: Tue, 11 Jun 2002 17:35:20 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: cfowler <cfowler@outpostsentinel.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Break on serial port
Message-ID: <20020611173520.D3665@flint.arm.linux.org.uk>
In-Reply-To: <1023810086.21809.26.camel@moses.outpostsentinel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 11:41:26AM -0400, cfowler wrote:
> I remeber a while back being able to send a break on serial console. 
> I've been unable to do this under 2.4.17.  Has this feature been turned
> off?  Is there a way to turn it back on?

It works fine here.  Please confirm that:

1. your kernel is built with CONFIG_MAGIC_SYSRQ
2. cat /proc/sys/kernel/sysrq returns '1'
3. the serial console port is being held open by some user program (eg,
   getty or init)

If any of the three above are not true, then break<sysrq-key> doesn't work.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

