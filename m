Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbTHYK1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 06:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbTHYK1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 06:27:37 -0400
Received: from smtp7.wanadoo.fr ([193.252.22.29]:42001 "EHLO
	mwinf0204.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261609AbTHYK1e convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 06:27:34 -0400
From: Laurent =?iso-8859-1?q?Hug=E9?= <laurent.huge@wanadoo.fr>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Personnal line discipline difficulties
Date: Mon, 25 Aug 2003 12:27:30 +0200
User-Agent: KMail/1.5.2
References: <200308251018.58127.laurent.huge@wanadoo.fr> <200308251054.48574.laurent.huge@wanadoo.fr> <20030825102923.A30952@flint.arm.linux.org.uk>
In-Reply-To: <20030825102923.A30952@flint.arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200308251227.30250.laurent.huge@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Lundi 25 Août 2003 11:29, vous avez écrit :
> > As I've told before, I've got no other way to know
> > it, so it's necessary to me (moreover, I'm trying to port an existing
> > driver from Windows to Linux, and the Windows serial driver gives
> > accurately the size of each PDU, so there must be a way).
> Maybe its embedded in the PDU somewhere, or maybe it requires knowledge
> of the protocol at driver level?
No, I'm sure there's no way to find that size but through the serial port 
reception.
I've already tried to totally replace the serial driver (by using inb and outb 
in the serial adress map) but it proves to be not fast enought (it worked à 
9600 bauds, but not at 115200 : I miss some PDU) ; so I've turned to use the 
kernel serial driver. Do you think I have to go way back and try to 
accelerate my treatment (I thought the kernel driver would be the fastest and 
most accurate) ?
> One thing bothers me though - why are you trying to deliver these
> characters into the network stack?  Wouldn't it be easier for your
> application to talk to the printer port via your custom driver and
> a serial port directly?
Because there's no application ! In fact, there are two flow through that 
driver : one is IP and the other is CCSDS (spatial protocols) ; I have to be 
_totally_ transparent to IP flow, and add CCSDS above. That's the reason why 
I've chosen to use the network stack.
-- 
Laurent Hugé.

