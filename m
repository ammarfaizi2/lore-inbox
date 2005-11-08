Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbVKHBfr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbVKHBfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVKHBfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:35:47 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:57635 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965095AbVKHBfq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:35:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PR9phnUAlNWeybQOQ09jGOOvAYaII3K0VwxSLbNw/sssZa4Macl87ZRX6k2DuYM5GixVIzPld4MtJha8c4ic7k6+IDD+Vj4oZHPFmk36e+3Cb3By5NsWMyUlCrGEtM/dDjg6Pue+7nc2WGM/FPbGejvnds1XbXksq0CGR1Refl4=
Message-ID: <4807377b0511071735p5acd862h6569f2b0b57deb41@mail.gmail.com>
Date: Mon, 7 Nov 2005 17:35:46 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: Adayadil Thomas <adayadil.thomas@gmail.com>
Subject: Re: (2.6.12) Unable to handle kernel paging request at virtual address 00100100
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <fb7befa20511071506m59dd3420y3ca522d2b0667cbb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <fb7befa20511071506m59dd3420y3ca522d2b0667cbb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is LIST_POISON, see include/linux/list.h

On 11/7/05, Adayadil Thomas <adayadil.thomas@gmail.com> wrote:
> Kernel Version: 2.6.12
>
> I am debugging one module I have written. (ip_conntrack_dos)
> Given below is the Oops message.
>
> It would be greatly appreciated if someone could answer the questions I have.
>
> 1. "Unable to handle kernel paging request at virtual address 00100100" -->
> I am wondering if this is a 2.6.12 's general issue or something to do
> with my module.
>
> 2. I have the System.map that was crated when I compiled the 2.6.12 kernel.
> This does'nt contain the symbols relevant to my module.
> How can I get a System.map after I load my module ?
>
> Any information is much appreciated.
>
> Thanks
>
>     <1>Unable to handle kernel paging request at virtual address 00100100
>     <1> printing eip:
>     <4>f8bb245b
>     <1>*pde = 00000000
>     <1>Oops: 0000 [#1]
>     <4>PREEMPT SMP
>     <4>Modules linked in: ip_conntrack_dos e1000
>     <4>CPU:    0
>     <4>EIP:    0060:[<f8bb245b>]    Tainted: P      VLI
>     <4>EFLAGS: 00010246   (2.6.12)
>     <4>EIP is at init_conntrack_syn+0x193/0x214 [ip_conntrack_dos]
>     <4>eax: dd0f34b3   ebx: f48de908   ecx: f48de900   edx: 00000000
>     <4>esi: f4c65bc8   edi: f48de900   ebp: 00100100   esp: c040dae0
>     <4>ds: 007b   es: 007b   ss: 0068
>     <4>Process swapper (pid: 0, threadinfo=c040c000 task=c036eb00)
>     <4>Stack: 0239ed81 c040db20 f69a4480 f7549000 f48de900 f48de91c
> 000023a8 f8ca1000
>     <4>       00000000 00000000 f8bb27bf c040db20 0239ed81 c040dbf0
> 80000000 c02cb5d0
>     <4>       a5ecad96 c0406108 010a0a0a c0065000 f7549000 00000000
> c02b82b1 c02b860f
>     <4>Call Trace:
>     <4> [<f8bb27bf>] help+0x1ff/0x22c [ip_conntrack_dos]
>     <4> [<c02cb5d0>] br_dev_queue_push_xmit+0x0/0xe4
>     <4> [<c02b82b1>] ipt_route_hook+0x21/0x28
>     <4> [<c02b860f>] ip_nat_out+0x63/0x68
>     <4> [<c02af922>] ip_conntrack_help+0x26/0x38
>     <4> [<c027908b>] nf_iterate+0x33/0x70
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
