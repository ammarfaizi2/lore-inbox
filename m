Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264133AbUDRFn1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 01:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264137AbUDRFn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 01:43:27 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:34702 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S264133AbUDRFnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 01:43:23 -0400
From: Eric <eric@cisu.net>
Reply-To: eric@cisu.net
To: <stl@nuwen.net>
Subject: Re: Process Creation Speed
Date: Sun, 18 Apr 2004 00:44:02 -0500
User-Agent: KMail/1.6.1
Cc: <linux-kernel@vger.kernel.org>
References: <200404170219.i3H2JYal007333@localhost.localdomain>
In-Reply-To: <200404170219.i3H2JYal007333@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404180044.02850.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 April 2004 21:16, Stephan T. Lavavej wrote:
> Why does creating and then terminating a process in GNU/Linux take about
> 6.3 ms on a Prestonia-2.2?  I observe basically the same thing on a
> PIII-600.
>
> I'm pretty sure both systems run 2.4.x kernels.  Does this suck less under
> 2.6.x?  Not sucking at all would mean about 100 microseconds to me.  I
> don't understand why it doesn't scale with processor speed.  Does this
> interact with the length of a timeslice?
>
> It matters to me because the Common Gateway Interface spawns and destroys a
> process to handle each request, and I wish it were just fast, rather than
> having to use FastCGI.
	The difference in speed between regular and FastCGI shouldnt be related to 
process creation time. The speed up you see from FastCGI is because it 
doesn't have to be read from disk each time. So, you're really looking for 
performace enhancements in the wrong place. Tweaking process creation can't 
make your platters spin faster.

> A fair amount of Googling and RTFFAQ didn't answer this.
>
> Stephan T. Lavavej
> http://nuwen.net
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
