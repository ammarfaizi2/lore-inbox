Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313206AbSEMM6S>; Mon, 13 May 2002 08:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313238AbSEMM6R>; Mon, 13 May 2002 08:58:17 -0400
Received: from linuxpc1.lauterbach.com ([213.70.137.66]:665 "HELO
	linuxpc1.lauterbach.com") by vger.kernel.org with SMTP
	id <S313206AbSEMM6Q>; Mon, 13 May 2002 08:58:16 -0400
Message-Id: <5.1.1.2.2.20020513144903.02885310@mail.lauterbach.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1.3 (Beta)
Date: Mon, 13 May 2002 14:58:10 +0200
To: linux-kernel@vger.kernel.org
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: pdc202xx.c fails to compile in 2.5.15
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > Because of there are apparently devices on which you must check device 
> class
> > (2.5.14 talks about CY82C693 and IT8172G), I'll leave proper fix on Martin,
> > but simple fix below work fine on my Asus A7V.
>
>You need to do specific checks for the device in question. Removing the
>class check btw is something anyone reading this message should not do
>even in the same situation unless they know precisely what other
>mass storage class devices they have present. You can easily trash a
>raid array otherwise

I think you are probably talking about the class check for unknown devices 
a few lines above in 2.5.15. Removing the class check when a driver already 
claimed responsibility just reinstates what we had in 2.4. The removal is 
in IDE 61.

Franz.

