Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318891AbSHEWjP>; Mon, 5 Aug 2002 18:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318900AbSHEWjP>; Mon, 5 Aug 2002 18:39:15 -0400
Received: from RJ226120.user.veloxzone.com.br ([200.165.226.120]:10624 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S318891AbSHEWjO>; Mon, 5 Aug 2002 18:39:14 -0400
Subject: Re: Bug at page_alloc.c:183
From: Victor Bogado da Silva Lins <victor@bogado.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1028485038.14196.37.camel@irongate.swansea.linux.org.uk>
References: <1028479242.2599.28.camel@victor.bogado> 
	<1028485038.14196.37.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Aug 2002 19:43:06 -0300
Message-Id: <1028587386.1761.4.camel@victor.bogado>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 15:17, Alan Cox wrote:
> On Sun, 2002-08-04 at 17:40, Victor Bogado da Silva Lins wrote:
> > Aug  4 12:44:59 victor kernel: invalid operand: 0000
> > Aug  4 12:44:59 victor kernel: CPU:    0
> > Aug  4 12:44:59 victor kernel: EIP:    0010:[<c0130031>]    Tainted: P
> 
> Take it up with Nvidia or duplicate the problem on a box that has never
> had the module loaded from a cold boot onwards

Made the same test without the NVidia card at all, I booted in single
user mode with a PCI all in wonder board I had here, started the network
and tried again I got a similar kernel bug, since I didn't have a logger
deamon running I just got a few lines of the bug :

kernel BUG at page_alloc.c:183!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0130031>]    Not tainted
EFLAGS: 00010086
eax: 0000007e   ebx: c10005f0   ecx: 00000000   edx: 0000001f
esi: c0283f00   edi: 00000001   ebp: 00000000   esp: cae39ee0
ds: 0018   es: 0018   ss: 0018
Process tar (pid: 4227, stackpage=cae39000)

	This test was made in run level 1, with almost nothing runing beside
the garnome compilation.

-- 
