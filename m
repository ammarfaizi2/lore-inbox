Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262063AbSIYTFa>; Wed, 25 Sep 2002 15:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262066AbSIYTF3>; Wed, 25 Sep 2002 15:05:29 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:13070 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S262063AbSIYTF2>; Wed, 25 Sep 2002 15:05:28 -0400
Date: Wed, 25 Sep 2002 16:10:40 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Bob_Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.38: oops with kernel LLC support enabled
Message-ID: <20020925191040.GE10073@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Bob_Tracy <rct@gherkin.frus.com>, linux-kernel@vger.kernel.org
References: <m17uEPg-0005khC@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17uEPg-0005khC@gherkin.frus.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 25, 2002 at 10:49:20AM -0500, Bob_Tracy escreveu:
> Firstly, a big thanks to Ingo for kksymoops...  2.5.38 panics right
> out of the chute with no way to save the oops output, so it's REALLY
> nice to have it decoded on the screen!!  Manual transcription of the
> oops output follows below.

yes, its a great help
 
> What was I trying to do with LLC support?  I have an old JetDirect

Hey, no need to excuses, its there, test and use it, using old protocols
is not something to be ashamed, neither hacking it... 8)

> interface in a LJ-III that speaks DLC/LLC only, and wanted to try to
> use it with Linux.  (It should go without saying that NT and Win2K
> can talk to it just fine :-)).  Both machines in a sample set of two
> panic the same way...  One is a desktop with the NIC driver built-in.
> The other (that produced the oops output below) is a Dell Latitude CPxJ
> with a modular Xircom Tulip cardbus driver.
> 
> I guess I should mention that I haven't tried this with a 2.4 kernel.

you can try, but the codebase there (and I assume you're talking about
the LLC stack in the 2.4-ac tree, as the one in the 2.4 stock is
incomplete) is old and I'm only now getting to a point where LLC in
2.5 is getting pretty stable (now as in today, 4am :) )

>  Unable to handle kernel NULL pointer dereference at virtual address 00000000
>   printing eip:
>  c0245da5
>  *pde = 00000000
>  Oops: 0000
>  kernel
>  CPU:    0
>  EIP:    0060:[<c0245da5>]	Not tainted
>  EFLAGS: 00010202
>  EIP is at llc_sap_find [kernel] 0x25
>  eax: c7fae000   ebx: c02e8e28   ecx: 000000aa   edx: 00000000
>  esi: 00000000   edi: 00000000   ebp: 00000000   esp: c7faffa8
>  ds: 0068   es: 0068   ss: 0068
>  Process swapper (pid: 1, threadinfo=c7fae000 task=c7fac040)
>  Stack: c02e8e28 000000aa 00000000 c0242141 000000aa c02e8e28 00000000 c02df8e1
>         c01f0ca0 00000000 000000aa c02d0712 c7fae000 c0105093 c0105060 00000000
>         00000000 00000000 c01054e5 00000000 00000000 00000000
>  Call Trace: [<c0242141>] llc_sap_open [kernel] 0x11
>  [<c01f0ca0>] snap_indicate [kernel] 0x0
>  [<c0105093>] init [kernel] 0x33
>  [<c0105060>] init [kernel] 0x0
>  [<c01054e5>] kernel_thread_helper [kernel] 0x5

Could you try with the next version Linus releases? I some fixes already
commited into Linus bk tree, some still in DaveM's tree and some waiting
for DaveM to pull that, I think, will solve your problem, and wow, don't
give up, at least I'd have one more person testing my work 8)

Just let me know if you'd like to get a diff from the latest Linus
released kernel to the latest stuff I have, I'll be glad to provide and
to receive test results.

Best Regards,

- Arnaldo
