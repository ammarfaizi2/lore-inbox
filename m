Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVGYT1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVGYT1e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261473AbVGYTZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:25:10 -0400
Received: from [195.23.16.24] ([195.23.16.24]:44954 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261472AbVGYTXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:23:22 -0400
Message-ID: <42E53C25.10100@grupopie.com>
Date: Mon, 25 Jul 2005 20:23:17 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Bernd Petrovitsch <bernd@firmix.at>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Grant Coady <lkml@dodo.com.au>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Puneet Vyas <vyas.puneet@gmail.com>
Subject: Re: xor as a lazy comparison
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>	 <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>	 <Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>	 <42E4131D.6090605@gmail.com>  <1122281833.10780.32.camel@tara.firmix.at>	 <1122314150.6019.58.camel@localhost.localdomain> <1122318659.1472.14.camel@mindpipe>
In-Reply-To: <1122318659.1472.14.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Mon, 2005-07-25 at 13:55 -0400, Steven Rostedt wrote: 
> 
>>Doesn't matter. The cycles saved for old compilers is not rational to
>>have obfuscated code.
> 
> Where do we draw the line with this?  Is x *= 2 preferable to x <<= 2 as
> well?

I guess this depends on what you logically want to do. If the problem 
requires you to shift some value N bits, then you should use a shift 
operation.

If what you want is to multiply a value by a certain ammount, you should 
just use a multiplication.

Using a shift to perform the multiplication should be left to the 
compiler IMHO.

The proof that the shift is not so clear is that even you got the shift 
wrong in your own example ;)

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
