Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVGGDw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVGGDw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 23:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbVGGDu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 23:50:29 -0400
Received: from mail21.sea5.speakeasy.net ([69.17.117.23]:64420 "EHLO
	mail21.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S262208AbVGGDtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 23:49:19 -0400
Message-Id: <6.2.3.4.0.20050706214134.03ce1d00@no.incoming.mail>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.3.4
Date: Wed, 06 Jul 2005 21:49:07 -0600
To: <rol@as2917.net>
From: Jeff Woods <Kazrak+kernel@cesmail.net>
Subject: Re: "Spy'ing" characters sent thru serial port ?
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200507061506.j66F6dR25621@tag.witbe.net>
References: <200507061506.j66F6dR25621@tag.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howdy.

At 7/6/2005 17:06 +0200, Paul Rolland wrote:
>We have a machine connected to a modem using the serial port, and 
>from time to time, the modem complains the machine sent him a full 
>2K buffer (in fact, 2047 bytes) which were already sent.
>
>We've been investigating at the application level, using strace to 
>monitor what is sent to the serial port, and at no time such a buffer is sent.
>
>This problem is occurring on a random basis, and attempts to 
>reproduce it in a test environment failed to date.
>
>Is it possible to '(log|copy|...)' the chars that are sent on the 
>serial port to some other place (without altering too much the 
>performance of the machine, we are running the port a 9600bps), at 
>the lowest level ?

I don't have any software answers, but it sounds like the modem is an 
external type connected by RS232 cable to a serial port.  RS-232 is 
pretty simple at the hardware level and you should be able to create 
a "Y" cable that "sniffs" the transmit from the computer to modem 
line without interrupting the dialogue between the serial port and 
modem. Just connect the transmit and signal ground lines to the 
receive and signal ground lines of a serial terminal or another 
computer with some terminal software (or even "cat </dev/serial1" or 
similar) listening to the serial port.  Back in Ye Olde Days (1980s) 
we used to diagnose modem problems like that all the time.

--
Jeff Woods <kazrak+kernel@cesmail.net> 

