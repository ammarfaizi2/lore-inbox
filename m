Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262834AbRE0RdJ>; Sun, 27 May 2001 13:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262835AbRE0Rct>; Sun, 27 May 2001 13:32:49 -0400
Received: from faui02.informatik.uni-erlangen.de ([131.188.30.102]:63716 "EHLO
	faui02.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id <S262834AbRE0Rck>; Sun, 27 May 2001 13:32:40 -0400
Date: Sun, 27 May 2001 19:16:14 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: tim@cyberelk.net, linux-kernel@vger.kernel.org
Subject: insl/outsl in parport_pc and !CONFIG_PCI
Message-ID: <20010527191613.A2808@rz.informatik.uni-erlangen.de>
Mail-Followup-To: Richard Zidlicky <rz@linux-m68k.org>, tim@cyberelk.net,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

How is that supposed to work on systems without PCI? For now I have
defined 

#define insl(port,buf,len)   isa_insb(port,buf,(len)<<2)
#define outsl(port,buf,len)  isa_outsb(port,buf,(len)<<2)

in asm-m68k/parport.h.

Bye
Richard
