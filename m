Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284855AbRLEXqv>; Wed, 5 Dec 2001 18:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284851AbRLEXqj>; Wed, 5 Dec 2001 18:46:39 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:19460 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S284853AbRLEXqY>;
	Wed, 5 Dec 2001 18:46:24 -0500
Message-Id: <5.1.0.14.0.20011206104048.0213de70@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 06 Dec 2001 10:46:20 +1100
To: <linux-kernel@vger.kernel.org>
From: Stuart Young <sgy@amc.com.au>
Subject: Re: NVIDIA kernel module
Cc: Erik Elmore <lk@bigsexymo.com>
In-Reply-To: <Pine.LNX.4.33.0112051719260.13083-100000@erik.bigsexymo.co
 m>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:22 PM 5/12/01 -0600, Erik Elmore wrote:
>Have I lost my mind?
>
>I've always thought that NVIDIA's linux kernel support was incredibly
>closed source, but I swear I just saw a download link for the kernel
>module sources at http://www.nvidia.com/view.asp?PAGE=linux
>
>was I mistaken or is this something new?

The "sources" you see there are the following:

- A Makefile
- The Nvidia binary module
- Some source code that wraps around the binary module and interfaces to 
the kernel functions, agp, etc.

This gives some flexibility when it comes to using it with different 
kernels, The "kernel layer" compiles against and uses information from the 
kernel at /usr/src/linux (or the one you specify through parameters). This 
also means they don't have to release a new binary for every kernel release 
(can you imagine how horrible that would be?), or track a huge number of 
kernel changes.

Most of the guts are still a closed binary module (for x86 only) that 
hasn't had any peer review.

Stuart Young - sgy@amc.com.au
(aka Cefiar) - cefiar1@optushome.com.au

[All opinions expressed in the above message are my]
[own and not necessarily the views of my employer..]

