Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312790AbSEHMyt>; Wed, 8 May 2002 08:54:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314041AbSEHMys>; Wed, 8 May 2002 08:54:48 -0400
Received: from [80.120.128.82] ([80.120.128.82]:17157 "EHLO hofr.at")
	by vger.kernel.org with ESMTP id <S312790AbSEHMyr>;
	Wed, 8 May 2002 08:54:47 -0400
From: Der Herr Hofrat <der.herr@mail.hofr.at>
Message-Id: <200205081200.g48C0a805476@hofr.at>
Subject: Re: Measure time
In-Reply-To: <abaokj$ugl$1@news.lucky.net> from "Serguei I. Ivantsov" at "May
 8, 2002 11:48:24 am"
To: "Serguei I. Ivantsov" <administrator@svitonline.com>
Date: Wed, 8 May 2002 14:00:36 +0200 (CEST)
CC: linux-gcc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello!
> 
> Is there any function for high precision time measuring.
> time() returns only in second. I need nanoseconds.
>
you can directly read the TSC but that will not realy give you nanoseconds
resolution as the actual read access even on a PIII/1GHz is going to take
up to a few 100 nanoseconds, and depending on what you want to time
stamp the overall jitter of that code can easaly be in the
range of a microsecond. 

There are some hard-realtime patches to the Linux kernel that will
allow time precission of aprox. 1us (the TSC has a precission of 32ns)
but I don't think you can get below that without dedicated hardware.

for RTLinux check at ftp://ftp.rtlinux.org/pub/rtlinux/ 

hofrat
