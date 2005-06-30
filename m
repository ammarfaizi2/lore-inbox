Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbVF3I2Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbVF3I2Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 04:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbVF3I2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 04:28:15 -0400
Received: from mx1.suse.de ([195.135.220.2]:36503 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262886AbVF3I17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 04:27:59 -0400
From: Gernot Payer <gpayer@suse.de>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: Patch to disarm timers after an exec syscall
Date: Thu, 30 Jun 2005 10:27:57 +0200
User-Agent: KMail/1.6.2
References: <200506291455.45468.gpayer@suse.de> <20050629182725.GF9153@shell0.pdx.osdl.net>
In-Reply-To: <20050629182725.GF9153@shell0.pdx.osdl.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200506301027.57380.gpayer@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 June 2005 20:27, Chris Wright wrote:
> No, this can't do.  It conflicts with the other bit of requirements.
> Specifically:
> http://www.opengroup.org/onlinepubs/009695399/functions/exec.html
>
> As you mention:
>
>   [TMR] Per-process timers created by the calling process
>   shall be deleted before replacing the current process image with the new
>   process image.
>
> But also:
>
>   The new process shall inherit at least the following attributes from the
>   calling process image:
>   <snip>
>   o [XSI] Interval timers
>
> And this kills the latter.

Ah, thanks for pointing that out. Unfortunately this fact isn't made clear in 
the timer_create page and the exec page isn't very understandable for 
non-native speakers and non-lawyers. ;-)

But after reading the parts you mentioned (expecially the [XSI] and [TMR] 
acronyms), I have to agree with you, the patch is wrong and so is the test 
case I mentioned.

However, poking around in the kernel was fun anyway. ;-)

> thanks,
> -chris

mfg
Gernot
