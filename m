Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262661AbULPNWD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbULPNWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 08:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbULPNWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 08:22:03 -0500
Received: from mail.mev.co.uk ([62.49.15.74]:5313 "EHLO mail.mev.co.uk")
	by vger.kernel.org with ESMTP id S262669AbULPNRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 08:17:42 -0500
Message-ID: <41C18AF1.30009@mev.co.uk>
Date: Thu, 16 Dec 2004 13:17:37 +0000
From: Ian Abbott <abbotti@mev.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 2.4] serial closing_wait and close_delay
References: <41ACC49A.20807@mev.co.uk> <20041213115640.GI24597@logos.cnet>
In-Reply-To: <20041213115640.GI24597@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Dec 2004 13:17:38.0120 (UTC) FILETIME=[9D301480:01C4E371]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/04 11:56, Marcelo Tosatti wrote:
> On Tue, Nov 30, 2004 at 07:06:02PM +0000, Ian Abbott wrote:
>>* In several drivers, the closing_wait and close_delay values are 
>>written to a struct serial_state by TIOCSSERIAL, but the values used in 
>>the close routine are read from a struct async_struct, with no code to 
>>transfer of values between the two structures.  My patch ignores the 
>>members in struct async_struct and uses the values from struct serial_state.
> 
> 
> Can you please split this part of the patch? (and send as a separate patch
> to me CC Alan and Russell).

Okay, I'm about to send that.  By the way, while going through my 
original patch, I noticed that one of its changes to drivers/char/moxa.c 
was incorrect.  Line 671 of the original used a fixed 30 second timeout. 
  My change replaced that to use closing_wait but I got the name of the 
variable wrong; it should have been 'ch', not 'info'.  My split-off 
patch doesn't change moxa.c.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>        )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587         )=-
