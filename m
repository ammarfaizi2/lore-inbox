Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277366AbRJZCz3>; Thu, 25 Oct 2001 22:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277380AbRJZCzT>; Thu, 25 Oct 2001 22:55:19 -0400
Received: from mx3.port.ru ([194.67.57.13]:64265 "EHLO smtp3.port.ru")
	by vger.kernel.org with ESMTP id <S277366AbRJZCzE>;
	Thu, 25 Oct 2001 22:55:04 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200110260257.f9Q2vhg09527@vegae.deep.net>
Subject: Re: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
To: urban@teststation.com (Urban Widmark)
Date: Fri, 26 Oct 2001 06:57:42 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0110252253270.7785-100000@cola.teststation.com> from "Urban Widmark" at Oct 25, 2001 11:19:51 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"  Urban Widmark wrote:"
> >        Hello folks...
> > 
> > 	Host A: p166, ISA NE2K, linux-2.4.12-ac4
> > 	Host B: p2-400, rtl-8129, WinXP (heh, not my box though ;)
> > 
> > 	Load: smbmount connection from host A to the host B, and getting
> >      large files.
> 
> You don't say if any of the tests you did are related to smbfs. I suspect
> this reasoning is completely irrelevant (not, that it has stopped me
> before ... :)
> 
> smbfs is not the fastest thing around. I think the slowness on some
> operations is related to how it waits after sending each request.
> 
>      process A				  process B
>    get semaphore
>    request 4096 bytes			wait on semaphore
>    ... wait for network ...
>    read packet
>    read packet
>    read packet
>    release semaphore
> 					get semaphore
> 					request 4096 bytes
> 
> It could send the second request without waiting for the first to complete
> (if it knew how to separate the responses). Doing that should speed things
> up.
> 
> If you play mp3's over smbfs while also doing something else I suppose the
> delay could become noticable. I can't explain the other effects, so
> possibly this is unrelated to smbfs.
> 
> You could make me happy by repeating the tests, but generating the network
> load with something else (http?).
> 
> /Urban
> 
> 
> 
        1. /dev/hda is -u1d1 `ed, and the disc load is near to not existent
	2. mp3 is placed locally

cheers, Samium Gromoff

