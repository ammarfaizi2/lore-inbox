Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282523AbRLWOYH>; Sun, 23 Dec 2001 09:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282483AbRLWOX5>; Sun, 23 Dec 2001 09:23:57 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:8467 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282523AbRLWOXj>; Sun, 23 Dec 2001 09:23:39 -0500
Date: Sun, 23 Dec 2001 14:23:31 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Andreas Gietl <a.gietl@e-admin.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: serial console on > 2.4.14
Message-ID: <20011223142331.A27993@flint.arm.linux.org.uk>
In-Reply-To: <E16I9Fq-0007yj-00@d101.x-mailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16I9Fq-0007yj-00@d101.x-mailer.de>; from a.gietl@e-admin.de on Sun, Dec 23, 2001 at 03:06:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2001 at 03:06:58PM +0100, Andreas Gietl wrote:
> I compiled all kernels with the same configuration with serial console-option 
> enabled. With 2.4.14 everything is just fine: I see the kernel-output and can 
> type in things during startup esp. do a fsck. With 2.4.16 and 2.4.17 i SEE 
> everything but no input is accepted.

>From what I've deduced, there are a number of SysVinit implementations out
there that incorrectly clear the terminals CREAD flag.

       [-]cread
              allow input to be received

Obviously if it is cleared, then you'll see your behaviour.  If you can log
into the box some other way, please check the settings using:

	stty -aF /dev/ttyS0

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

