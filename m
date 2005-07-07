Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262203AbVGGFRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262203AbVGGFRn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 01:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262206AbVGGFRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 01:17:43 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:16653 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262203AbVGGFRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 01:17:42 -0400
Date: Thu, 7 Jul 2005 07:15:24 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Paul Rolland <rol@as2917.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "Spy'ing" characters sent thru serial port ?
Message-ID: <20050707051523.GN8907@alpha.home.local>
References: <200507061506.j66F6dR25621@tag.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507061506.j66F6dR25621@tag.witbe.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

you might want to try to boot your software into an emulator such as vmware
and sniff the communications between the virtual machine and the real device.
This way, you will know if it is the OS which is retransmitting data to the
hardware.

Regards,
willy

On Wed, Jul 06, 2005 at 05:06:30PM +0200, Paul Rolland wrote:
> Hello,
> 
> We have a machine connected to a modem using the serial port, and from
> time to time, the modem complains the machine sent him a full 2K buffer
> (in fact, 2047 bytes) which were already sent.
> 
> We've been investigating at the application level, using strace to 
> monitor what is sent to the serial port, and at no time such a buffer is
> sent.
> 
> This problem is occuring on a random basis, and attempts to reproduce
> it in a test environment failed to date.
> 
> Is it possible to '(log|copy|...)' the chars that are sent on the
> serial port to some other place (without altering too much the performance
> of the machine, we are running the port a 9600bps), at the lowest level ?
> 
> Or is there a known issue of the serial port (or tty) buffer being 
> resent on the line in some weird conditions ? Any change done on 
> ->head and ->tail handling that could fix that ?
> 
> This problem is with Linux 2.4.27 (I know 2.4.31 is out, but nothing 
> related to that is present in the Changelog)
> 
> Regards,
> Paul
> 
> Paul Rolland, rol(at)as2917.net
> ex-AS2917 Network administrator and Peering Coordinator
> 
> --
> 
> Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur
> "Some people dream of success... while others wake up and work hard at it" 
> 
> "I worry about my child and the Internet all the time, even though she's 
> too young to have logged on yet. Here's what I worry about. I worry that 
> 10 or 15 years from now, she will come to me and say 'Daddy, where were 
> you when they took freedom of the press away from the Internet?'"
> --Mike Godwin, Electronic Frontier Foundation 
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
