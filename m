Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282916AbRLMKhx>; Thu, 13 Dec 2001 05:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282190AbRLMKho>; Thu, 13 Dec 2001 05:37:44 -0500
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:18194 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S281818AbRLMKhf>; Thu, 13 Dec 2001 05:37:35 -0500
Date: Thu, 13 Dec 2001 10:36:52 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Thomas Hood <jdthood@mail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB not processing APM suspend event properly?
Message-ID: <20011213103652.A8007@flint.arm.linux.org.uk>
In-Reply-To: <1008205428.3108.0.camel@thanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1008205428.3108.0.camel@thanatos>; from jdthood@mail.com on Wed, Dec 12, 2001 at 08:03:48PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2001 at 08:03:48PM -0500, Thomas Hood wrote:
> But do you agree that the present code does NOT do this?
> 
> The present code does not send 'n' events---only one.

Ok, thinking about this obfuscated code more, it would appear so.  It
would also appear that when the suspend request comes from the APM bios,
the ioctl() method will not call send_event() at all - instead it comes
from check_events().

However, as I said previously, this is a minor issue.  I'd rather the
major problem was fixed.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

