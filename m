Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262505AbTCMQpp>; Thu, 13 Mar 2003 11:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262504AbTCMQpp>; Thu, 13 Mar 2003 11:45:45 -0500
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:4107
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S262503AbTCMQpm>; Thu, 13 Mar 2003 11:45:42 -0500
Message-ID: <11E89240C407D311958800A0C9ACF7D1A33DDF@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'Linux PPP'" <linuxppp@indiainfo.com>
Cc: linux-serial@vger.kernel.org,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: RS485 communicatio
Date: Thu, 13 Mar 2003 08:56:26 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 12, 2003 at 10:15 PM, linuxppp@indiainfo.com wrote:
> Hi all,
> am currently working on PPP over serial interface (RS485) in 
> linux 2.4.2-2. I believe RS485 half duplex system and hence 
> only one can transmit at a time. And for RS485 we basicaly 
> use Master-Slave or Primary-Secondary kind of communication. 
> I don't know how to achieve the same using PPP since i need 
> to have max of 10 nodes connected via serial interface. I 
> tested with two nodes using PPP daemon it works fine. 
> Following are the commands i issued
> 
> In PPP server: 
> $usr/sbin/pppd -detach crtscts 10.10.10.100:10.10.10.101 
> 115200 /dev/ttyS0 &
> 
> In PPP client side : 
> $/usr/sbin/pppd call ppp-start 
> where ppp-start file is copied into directory /etc/ppp/peers/ 
> that had the following
> 
> -detach /dev/ttyS0 115200 crtscts
> noauth
> 
> This point to point communication worked fine with RS485 
> interface. If i had to connect one more node what i need to 
> do. Please clarify with the following 
> 
> i) Whether the existing pppd takes care of the RS485 with 
> multi node , if so how do i manage giving commands
> ii) If there is no direct support how do i go ahead. Is there 
> any other layer 2 protocol allows me to acheive TCP/IP 
> communicattion over RS485 which is my ultimatum.
> 
> I will be grateful if anybody of them could help me with my 
> current problem.
> 

I believe Point-to-Point Protocol only supports point-to-point symmetric
links. Don't think there is any multi-point support in the protocol. IIRC,
PPP also requires a full duplex link, which is not available on an RS-485
link with more than two stations, even if it is a 4-wire link. 

I don't know of an easy way around this fundamental limitation.

Maybe somebody on the kernel list has a suggestion.

Cheers

---------------------------------------------------------------- 
Ed Vance              edv (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------
