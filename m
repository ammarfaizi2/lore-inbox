Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132011AbRCVNJ5>; Thu, 22 Mar 2001 08:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132012AbRCVNJs>; Thu, 22 Mar 2001 08:09:48 -0500
Received: from chaos.analogic.com ([204.178.40.224]:39040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132011AbRCVNJi>; Thu, 22 Mar 2001 08:09:38 -0500
Date: Thu, 22 Mar 2001 08:08:01 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Schwartz <davids@webmaster.com>
cc: kern@e-zebra.net, linux-kernel@vger.kernel.org
Subject: RE: hostid derived from...
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKCEGINPAA.davids@webmaster.com>
Message-ID: <Pine.LNX.3.95.1010322080519.20107A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, David Schwartz wrote:

> 
> > how does linux provide the hostid string?
> >
> > on a sun box this is a guaranteed unique identifier, since AFAIK
> > intel architecture does not have this unique identifier can
> > two linux boxes end up with same hostid by chance?
> 
> 	If a Linux box is properly administered, it's hostid should not be the same
> as any other Linux box that is properly administered. Of course, Linux does
> nothing to stop you from shooting yourself in the foot.
> 
> 	DS
> 

The host ID is the network IP address in network order, displayed
as a hexadecimal number.

The program, `hostid`  first looks in /etc/hostid.
If no such file exists, it resolves the host IP address and
uses it, but not as the typical dotted-quad. Instead, it uses
hex in network order.

IP address 204.178.40.224

0xb2cce028
   | | | |_______ 40
   | | |_________ 224
   | |___________ 204
   |_____________ 178

It has nothing to do with the kernel. If you are properly networked,
the hostid will be unique in your LOCAL network.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


