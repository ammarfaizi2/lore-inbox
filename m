Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265716AbSKATTs>; Fri, 1 Nov 2002 14:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265717AbSKATTs>; Fri, 1 Nov 2002 14:19:48 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:28098 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265716AbSKATTq> convert rfc822-to-8bit; Fri, 1 Nov 2002 14:19:46 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 (vanilla ? mcp1)  build error
Date: Fri, 1 Nov 2002 20:25:53 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Pawel Bernadowski <pbern@wilnet.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211012025.45333.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

> on both version ( linux-2.5.45 and linux-2.5.45-mcp1):
> i have this problem:
>   gcc -Wp,-MD,net/ipv4/.ipmr.o.d -D__KERNEL__ -Iinclude -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer 
> -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 
> -march=i686 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    
> -DKBUILD_BASENAME=ipmr   -c -o net/ipv4/ipmr.o net/ipv4/ipmr.c
> net/ipv4/ipmr.c: In function `ipmr_forward_finish':
> net/ipv4/ipmr.c:1114: structure has no member named `pmtu'
> net/ipv4/ipmr.c: In function `ipmr_queue_xmit':
> net/ipv4/ipmr.c:1170: structure has no member named `pmtu'
> net/ipv4/ipmr.c: At top level:
> net/ipv4/ipmr.c:111: warning: `pim_protocol' defined but not used
> make[2]: *** [net/ipv4/ipmr.o] Error 1
> make[1]: *** [net/ipv4] Error 2
> make: *** [net] Error 2
> error: Bad exit status from /var/tmp/rpm-tmp.3879 (%build)
seems I forgot a patch. This one should fix it:

 http://marc.theaimsgroup.com/?l=linux-kernel&m=103614599321384&w=2


ciao, Marc
