Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310921AbSCHPw1>; Fri, 8 Mar 2002 10:52:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310920AbSCHPwS>; Fri, 8 Mar 2002 10:52:18 -0500
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S310922AbSCHPwE>; Fri, 8 Mar 2002 10:52:04 -0500
Date: Fri, 8 Mar 2002 10:51:37 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Christopher Quinn <cq@htec.demon.co.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Interprocess shared memory .... but file backed?
In-Reply-To: <3C88D3F2.40807@htec.demon.co.uk>
Message-ID: <Pine.LNX.3.95.1020308104853.247B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Christopher Quinn wrote:

> Hello,
> 
> I know that a combination of mmap/shmem can be used to 
> achieve interprocess shared memory (notably Ralf 
> Engelschall's MM library).
> However as far as I can tell this is anonymous memory only.
> Are there any options if one initially maps a disk file via 
> mmap (in particular MAP_PRIVATE) for sharing that vm, such 
> that any access by a member of the sharing process group 
> will fault in the relevant file data page after which writes 
> to it are seen by all?

Hmmm. You want MAP_SHARED, but you insist upon using MAP_PRIVATE?
MAP_SHARED makes your mmapped pages visible to all, complete
with any updates by any or all tasks accessing it.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (799.53 BogoMips).

	Bill Gates? Who?

