Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266308AbTBCNX7>; Mon, 3 Feb 2003 08:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbTBCNX7>; Mon, 3 Feb 2003 08:23:59 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18833
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266308AbTBCNX7>; Mon, 3 Feb 2003 08:23:59 -0500
Subject: Re: Code: Bad EIP value
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "l.scheelings" <l.scheelings@kader.hobby.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E3EBF86.6050000@kader.hobby.nl>
References: <3E3EBF86.6050000@kader.hobby.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1044282594.20152.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 03 Feb 2003 14:29:55 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 19:14, l.scheelings wrote:
> EIP: 0050:[<00008865>] Not tainted
> EFLAGS: 00010046
> eax: 0005301 ebx: 00000001 ecx: 00000000 edx: 00000000
> esi: 00008136 edi: 00000296 ebp: 67890000 esp: c8ae7dd0
> ds:  0058 es: 000 ss: 0018
> Process halt cpid: 2559, stackpage+ c8ae70000
> stack: 02968df  81360000 00000000
>           0000000 00000000  81250058
>           c01148dd 00000010
> 
> call Trace : [<c01148dd>] [<c0110000>]
> 
> Code: Bad EIP value

It crashed in the BIOS code. A lot of old K6 boxes have bioses where the
32bit power down function Linux normally uses is buggy. Building a
kernel with the apm real mode power down option might work better.

