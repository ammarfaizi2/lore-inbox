Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315133AbSDWKYZ>; Tue, 23 Apr 2002 06:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315135AbSDWKYY>; Tue, 23 Apr 2002 06:24:24 -0400
Received: from law2-f136.hotmail.com ([216.32.181.136]:21522 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S315133AbSDWKYY>;
	Tue, 23 Apr 2002 06:24:24 -0400
X-Originating-IP: [203.195.140.212]
From: "Tulika Pradhan" <tulikapradhan@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: khc@pm.waw.pl, tulikapradhan@hotmail.com
Subject: new router
Date: Tue, 23 Apr 2002 10:24:15 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW2-F136ooIAJPBErv00002b8e@hotmail.com>
X-OriginalArrivalTime: 23 Apr 2002 10:24:15.0573 (UTC) FILETIME=[04EB6050:01C1EAB1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



hi !

i need to implement a router for my PC running linux. i need to take frame 
relay packets from the frame relay device and route it to another device. 
all the processing would be done by the already existing generic hdlc layer. 
one way to do this would be to write a socket application and read and write 
the packets from one socket to the other. however, this would make the 
system very slow. i want to add a routing functionality as part of the 
kernel to increase the throughput. i think the following can be done.

- make a new family for sockets (say, AF_MYROUTER) and make a socket 
interface for this. - using ioctl calls for SIOCADDRT and SIOCDELRT, routing 
table entries can be made and    deleted.
- also have my own protocol (say, ETH_P_MYPROTOCOL) and initiaize 
skb->protocol to this value in the generic hdlc code (instead of looking 
inside the frame relay packet and setting the protocol to ip etc.)

is it reasonable to add a new family for the above routing functionality ?


ps. please mark me a copy when you reply as i am not on the linux-kernel 
mailing list.

regards,

tulika

_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

