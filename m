Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750719AbWC0HZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWC0HZA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 02:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWC0HZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 02:25:00 -0500
Received: from smtpout.mac.com ([17.250.248.97]:23758 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750719AbWC0HY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 02:24:59 -0500
In-Reply-To: <4427900C.7090506@gmail.com>
References: <20060327004741.GA19187@MAIL.13thfloor.at> <1143422242.3589.2.camel@localhost.localdomain> <20060327033743.GA19788@MAIL.13thfloor.at> <1143437199.2221.3.camel@localhost.localdomain> <4427900C.7090506@gmail.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D993BFD8-BB08-4128-93C4-E919817E3C42@mac.com>
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Herbert Poetzl <herbert@13thfloor.at>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [Linux-fbdev-devel] Re: funny framebuffer fonts on PowerBook with radeonfb
Date: Mon, 27 Mar 2006 02:24:12 -0500
To: "Antonino A. Daplas" <adaplas@gmail.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 27, 2006, at 02:11:08, Antonino A. Daplas wrote:
> Benjamin Herrenschmidt wrote:
>> On Mon, 2006-03-27 at 05:37 +0200, Herbert Poetzl wrote:
>> Interesting... I suspect there is an endian bug in the new font  
>> code that hits odd sized fonts (or non-multiple-of-8 fonts). Can  
>> you try enabling 8x8 and 8x16 instead of 6x11 and 7x14 fonts and  
>> tell me if those work ?
>>
>> Tony: If my suspition is confirmed, I think that's your call :)
>
> It probably is, a remnant of the console rotation code.  If that is  
> truly the case, the patch I just sent in another thread should fix it.

I ran into this same bug on my Dual 1GHz Windtunnel G4 with an  
upgraded GPU (Radeon 9800) in the 2.6.16-rc4 timeframe.  Turning off  
the customized console font selection and reverting to the default  
list of fonts fixed the problem for me.  I think I had the console  
rotation config option turned on, but I don't have that config any  
more and can't be sure.

Cheers,
Kyle Moffett

