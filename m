Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292223AbSCDMFg>; Mon, 4 Mar 2002 07:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292329AbSCDMFQ>; Mon, 4 Mar 2002 07:05:16 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:54022 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S292326AbSCDMFG>; Mon, 4 Mar 2002 07:05:06 -0500
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: [patch] 2.5 videodev redesign -- #3
Date: 4 Mar 2002 09:47:33 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrna86gll.lh9.kraxel@bytesex.org>
In-Reply-To: <20020302151538.A7839@bytesex.org> <iss.28ea.3c83389c.370f5.1@mailout.lrz-muenchen.de>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 1015235253 22110 127.0.0.1 (4 Mar 2002 09:47:33 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Comments?  Bugs?  I plan to feed this to Linus soon ...
>  
>  Hi,
>  
>  it seems to me that you are not holding the BKL during
>  the open method of the individual driver. This will
>  cause races with unplugging on some USB cameras.

What race exactly?

I don't want videodev.c know details about the devices, it doesn't
belong there.  If a usb cam needs locking, the usb cam's open() function
should do that then.  I'll prefare fixing the usb drivers instead of
calling driver->open() with BKL held.  

  Gerd

-- 
#include </dev/tty>
