Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVGYT3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVGYT3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVGYT2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:28:05 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50916 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261282AbVGYTZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:25:37 -0400
Subject: Re: xor as a lazy comparison
From: Lee Revell <rlrevell@joe-job.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Bernd Petrovitsch <bernd@firmix.at>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Grant Coady <lkml@dodo.com.au>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Puneet Vyas <vyas.puneet@gmail.com>
In-Reply-To: <42E53C25.10100@grupopie.com>
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>
	 <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>
	 <Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>
	 <42E4131D.6090605@gmail.com>  <1122281833.10780.32.camel@tara.firmix.at>
	 <1122314150.6019.58.camel@localhost.localdomain>
	 <1122318659.1472.14.camel@mindpipe>  <42E53C25.10100@grupopie.com>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 15:25:35 -0400
Message-Id: <1122319535.1472.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-25 at 20:23 +0100, Paulo Marques wrote:
> Lee Revell wrote:
> > On Mon, 2005-07-25 at 13:55 -0400, Steven Rostedt wrote: 
> > 
> >>Doesn't matter. The cycles saved for old compilers is not rational to
> >>have obfuscated code.
> > 
> > Where do we draw the line with this?  Is x *= 2 preferable to x <<= 2 as
> > well?
> 
> I guess this depends on what you logically want to do. If the problem 
> requires you to shift some value N bits, then you should use a shift 
> operation.
> 
> If what you want is to multiply a value by a certain ammount, you should 
> just use a multiplication.
> 
> Using a shift to perform the multiplication should be left to the 
> compiler IMHO.
> 
> The proof that the shift is not so clear is that even you got the shift 
> wrong in your own example ;)
> 

Yeah, that was going to be my point, but I made it inadvertently before
I even got that far...

Lee

