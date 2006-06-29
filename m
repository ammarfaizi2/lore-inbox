Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWF2UkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWF2UkM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbWF2UkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:40:11 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:28121 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932436AbWF2UkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:40:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mouKFv2HE9qtWgpnnASLMjpWjBhkcVNz5W8x/N8HOyvOaZpGm9wnU6Z+b34wzHBP5ltoTj2a+LSxV2TpBFelLVciuJOH9mxNMTVOUq27O2SIrQtr6qgel7Pi5HSWxfSBdTSzx6pLASgCEGAgsmvSkJ0k8yLMDXlLCqR+2m1fmyw=
Message-ID: <6bffcb0e0606291339s69a16bc5ie108c0b8d4e29ed6@mail.gmail.com>
Date: Thu, 29 Jun 2006 22:39:33 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.17-mm4
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20060629013643.4b47e8bd.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060629013643.4b47e8bd.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/06/06, Andrew Morton <akpm@osdl.org> wrote:
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.17/2.6.17-mm4/
>
>

This looks very strange.

BUG: unable to handle kernel paging request at virtual address 6b6b6c07
printing eip:
c0138594
*pde=00000000
Oops: 0002 [#1]
4K_STACK PREEMPT SMP
last sysfs file /class/net/eth0/address
Modules linked in: ipv6 af_packet ipt_REJECT xt_tcpudp x_tables
p4_clockmod speedstep_lib binfmt_misc

(gdb) list *0xc0138594
0xc0138594 is in __lock_acquire (include2/asm/atomic.h:96).
warning: Source file is more recent than executable.

91       *
92       * Atomically increments @v by 1.
93       */
94      static __inline__ void atomic_inc(atomic_t *v)
95      {
96              __asm__ __volatile__(
97                      LOCK_PREFIX "incl %0"
98                      :"=m" (v->counter)
99                      :"m" (v->counter));
100     }

Here is a config file
http://www.stardust.webpages.pl/files/mm/2.6.17-mm4/mm-config

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
