Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265774AbSJTFYi>; Sun, 20 Oct 2002 01:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265776AbSJTFYi>; Sun, 20 Oct 2002 01:24:38 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:54538 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S265774AbSJTFYi>; Sun, 20 Oct 2002 01:24:38 -0400
Date: Sun, 20 Oct 2002 02:30:38 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv4: only produce one record in fib_seq_show
Message-ID: <20021020053038.GF15254@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20021020010331.GB15254@conectiva.com.br> <20021019.211307.00017347.davem@redhat.com> <20021020050849.GD15254@conectiva.com.br> <20021019.221557.124671756.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021019.221557.124671756.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Oct 19, 2002 at 10:15:57PM -0700, David S. Miller escreveu:
>    From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
>    Date: Sun, 20 Oct 2002 02:08:49 -0300
> 
> BTW:
>    
>    CONFIG_PROC_FS=y
>    [acme@oops net-2.5]$ l net/ipv4/built-in.o
>    -rw-rw-r--    1 acme     acme       328783 Out 20 01:44 net/ipv4/built-in.o
>    
>    CONFIG_PROC_FS=n
>    [acme@oops net-2.5]$ l net/ipv4/built-in.o
>    -rw-rw-r--    1 acme     acme       320708 Out 20 02:03 net/ipv4/built-in.o
> 
> Do not be fooled by build-in.o raw file sizes, a lot of the stuff in
> these unlinked objects are the unresolved symbol references that need
> to be fixed up by the final link of the kernel image.
> 
> Type "objdump --reloc built-in.o" and watch it fly by the screen :-)

Indeed it flies, but what would that say about the difference above? That shouldn't
imply that there is not space to be saved, isn't it? :-) I'm always learning new
stuff, that is good, thanks.

- Arnaldo
