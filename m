Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbREOS3H>; Tue, 15 May 2001 14:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261270AbREOS2r>; Tue, 15 May 2001 14:28:47 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:7186 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261246AbREOSWH>; Tue, 15 May 2001 14:22:07 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: strange behaviour in syscall
Date: 15 May 2001 11:21:35 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9drs3f$7b2$1@cesium.transmeta.com>
In-Reply-To: <Pine.SOL.3.96.1010515230910.8808A-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.SOL.3.96.1010515230910.8808A-100000@kohinoor.csa.iisc.ernet.in>
By author:    Sourav Sen <sourav@csa.iisc.ernet.in>
In newsgroup: linux.dev.kernel
> 
> 	But when I boot up that kernel that printk gets executed. While 
> booting, at least to my knowledge, that part of the code is not supposed
> to get executed. Also while the kernel goes down, that printk speaks
> again. 
> 
> 	All other system calls are working fine.
> 
> 	I am getting some oops and panic while that syscall executes, so I
> am suspicious that I am doing something that I should never have done.
> 
> 	Do anybody has any idea what might be going wrong?
> 
> Sorry to you all for disturbing,
> 

Yes, you are using system call numbers that have already been assigned
(in other kernel versions.)  libc tries to use them to see if they are
available, and so they seem to be.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
