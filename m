Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318209AbSHSJOR>; Mon, 19 Aug 2002 05:14:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318210AbSHSJOR>; Mon, 19 Aug 2002 05:14:17 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44301 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318209AbSHSJOR>; Mon, 19 Aug 2002 05:14:17 -0400
Date: Mon, 19 Aug 2002 10:18:14 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Carlos Velasco <carlosev@newipnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial Console
Message-ID: <20020819101814.A16410@flint.arm.linux.org.uk>
References: <200208191108120240.0D409F0A@192.168.128.16> <200208191110450791.0D42F6D9@192.168.128.16>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208191110450791.0D42F6D9@192.168.128.16>; from carlosev@newipnet.com on Mon, Aug 19, 2002 at 11:10:45AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2002 at 11:10:45AM +0200, Carlos Velasco wrote:
>   append="console=ttyS0,115200n8r console=tty0 vga=0x0301"
                                  ^
The 'r' means "use rts/cts flow control".  If CTS is not active, the
kernel will spin waiting to write the next characters to the serial
console.

> Is there something to solve this issue?

Don't specify 'r' in the append line.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

