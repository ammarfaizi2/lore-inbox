Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267025AbRGJSKG>; Tue, 10 Jul 2001 14:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbRGJSJq>; Tue, 10 Jul 2001 14:09:46 -0400
Received: from geos.coastside.net ([207.213.212.4]:64667 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S267025AbRGJSJh>; Tue, 10 Jul 2001 14:09:37 -0400
Mime-Version: 1.0
Message-Id: <p05100312b770f20411a0@[207.213.214.37]>
In-Reply-To: <Pine.LNX.3.95.1010710131403.18337A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1010710131403.18337A-100000@chaos.analogic.com>
Date: Tue, 10 Jul 2001 11:08:57 -0700
To: root@chaos.analogic.com, Timur Tabi <ttabi@interactivesi.com>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: What is the truth about Linux 2.4's RAM limitations?
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 1:35 PM -0400 2001-07-10, Richard B. Johnson wrote:
>Unlike some OS (like VMS), a context-switch does not occur
>when the kernel provides services for the calling task.
>Therefore, it was most reasonable to have the kernel exist within
>each tasks address space. With modern processors, it doesn't make
>very much difference, you could have user space start at virtual
>address 0 and extend to virtual address 0xffffffff. However, this would
>not be Unix. It would also force the kernel to use additional
>CPU cycles when addressing a tasks virtual address space,
>i.e., when data are copied to/from user to kernel space.

Certainly the shared space is convenient, but in what sense would a 
separate kernel space "not be Unix"? I'm quite sure that back in the 
AT&T days that there were Unix ports with separate kernel (vs user) 
address spaces, as well as processors with special instructions for 
doing the copies (move to/from user space). Having separate system & 
user base page table pointers makes this relatively practical.
-- 
/Jonathan Lundell.
