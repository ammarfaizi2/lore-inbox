Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278660AbRKNX7i>; Wed, 14 Nov 2001 18:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278665AbRKNX72>; Wed, 14 Nov 2001 18:59:28 -0500
Received: from [212.18.232.186] ([212.18.232.186]:19208 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S278660AbRKNX7V>; Wed, 14 Nov 2001 18:59:21 -0500
Date: Wed, 14 Nov 2001 23:59:08 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Roman Kurakin <rik@cronyx.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial.c Bug
Message-ID: <20011114235908.B19575@flint.arm.linux.org.uk>
In-Reply-To: <3BF24147.9030508@cronyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF24147.9030508@cronyx.ru>; from rik@cronyx.ru on Wed, Nov 14, 2001 at 01:02:47PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 01:02:47PM +0300, Roman Kurakin wrote:
>     I have found a bug. It is in support of serial cards which uses 
> memory for I/O insted of ports. I made a patch for serial.c and fix
> one place, but probably the problem like this one could be somewhere
> else.

I've got this fish caught in the my serial driver rewrite - the driver
always handles the requesting and freeing of the resources.  If it is
unable to request the resources, then you will receive a suitable error
when trying to configure two ports.

Please note that I'm not about to take on maintainence of the current
serial.c driver, except where I spot obvious bugs.

I'd recommend that you pass this one to Marcelo to incorporate (only
after he's got his feet on the ground again. 8))  It looks sensible.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

