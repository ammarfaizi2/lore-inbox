Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262847AbREVVjr>; Tue, 22 May 2001 17:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262848AbREVVjh>; Tue, 22 May 2001 17:39:37 -0400
Received: from fenrus.demon.co.uk ([158.152.228.152]:13201 "EHLO
	amadeus.home.nl") by vger.kernel.org with ESMTP id <S262847AbREVVjU>;
	Tue, 22 May 2001 17:39:20 -0400
Message-Id: <m152Jn6-000Oh3C@amadeus.home.nl>
Date: Tue, 22 May 2001 22:34:08 +0100 (BST)
From: arjan@fenrus.demon.nl
To: ionut@moisil.cs.columbia.edu (Ion Badulescu)
Subject: Re: Xircom RealPort versus 3COM 3C3FEM656C
cc: linux-kernel@vger.kernel.org
In-Reply-To: <200105222118.f4MLISL01588@moisil.badula.org>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200105222118.f4MLISL01588@moisil.badula.org> you wrote:
> On Tue, 22 May 2001 20:10:41 +0100 (BST), Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

>> Before you give up on the xircom thing, try the -ac kernel and set the box
>> up to use xircom_cb not xircom_tulip_cb
>> 
>> That might help a lot

> It doesn't, it still performs poorly with any of the three available
> drivers -- xircom_cb, xircom_tulip_cb, and tulip_cb (from the pcmcia package):

> * Rx gets only about 1.8Mbit/s on a 100Base-TX network with any of the three
> * Tx gets 80+Mb/s with xircom_tulip_cb and tulip_cb, and less than 30Mb/s
>  with xircom_cb.

This sounds like a bug I have heard before: some switches don't work with
the xircom card (well, our drivers for it) when doing full duplex.
Could you try the latest driver from 

http://people.redhat.com/arjanv

which forces the card to half-duplex? 
I manage to get 8Mbyte/sec with it without any problems.

Greetings,
   Arjan van de Ven



