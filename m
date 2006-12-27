Return-Path: <linux-kernel-owner+w=401wt.eu-S1754774AbWL0VK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754774AbWL0VK0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 16:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbWL0VKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 16:10:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47448 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774AbWL0VKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 16:10:24 -0500
Date: Wed, 27 Dec 2006 21:10:16 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Loye Young <loyeyoung@iycc.net>
cc: linux-kernel@vger.kernel.org, loye.young@iycc.net
Subject: Re: The Input Layer and the Serial Port 
In-Reply-To: <20061227195433.872F03FC063@hamlet.sw.biz.rr.com>
Message-ID: <Pine.LNX.4.64.0612272050240.19264@pentafluge.infradead.org>
References: <20061227195433.872F03FC063@hamlet.sw.biz.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> To the King of Penguins and the Wise Architects of the Kernel:
> 
> Greetings and Smooth Compiling to All,
> 
> I, a humble pilgrim in the Land of Tux, have spent over a year 
> seeking a simple answer to what seems to me a simple question: 
> How do I expose my RS232 barcode scanner to the input layer so
> that the scanned information shows up in applications? Basically,
> I need the scanner to act like another keyboard. Scan a code, 
> see the numbers. 

   By the magic of serio. Take for example the AT keyboard which is 
one of the most common keyboards in the world. I have seen and 
used it attached to a PC via parport, serial port and the standard 
PS/2 port. So to handle cases like this the input layer created a 
serio interface. This way it does matter what bus the keyboard is
attached to the same code can be used to drive the keyboard. 
   The good news for you is that a serial port serio exist already.
All you need to do is write the device interface. I recommend you
take a look at sermouse.c in the drivers/input.mouse directory
for a guide.

P.S
   In fact I have been playing with serio for a way to 
work with LCD panels that can be wired via parport, gpio etc.  
Its just so flexiable :-)
