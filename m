Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284952AbRLUSeu>; Fri, 21 Dec 2001 13:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284955AbRLUSei>; Fri, 21 Dec 2001 13:34:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28420 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284952AbRLUSe0>; Fri, 21 Dec 2001 13:34:26 -0500
Subject: Re: Concerning a driver rewrite (NOT THE KERNEL)
To: camel_3@hotmail.com (victor1 torres)
Date: Fri, 21 Dec 2001 18:44:28 +0000 (GMT)
Cc: camel_3@hotmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <F104E3w7oWRcmQ6hTr500001d21@hotmail.com> from "victor1 torres" at Dec 21, 2001 06:15:53 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E16HUei-0001Em-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I´m working on a Modem driver that run´s with kernel 2.4x I have got the 
> code running on a 2.2x system with no trouble. The driver is for a Ac´97 
> Modem (WINMODEM). The driver can find the modem and print out output but I 
> can´t seem to include DevFs, I would also like to implement Interrupt 
> Handling.
> Here is the driver location:
> DRIVER LOCATION IS
> http://www.geocities.com/camel_10.geo/linux/ac97_modem20011221.tar.gz

If you are also loading the sound driver you are likely to get into a mess
with current 2.4 because the sound code sticks its nose into the codec bus
somewhat further nowdays. You driver also seems to be assuming the sound
driver has initialised the codec bus and codecs.

How do you intend the two pieces to interact ?
