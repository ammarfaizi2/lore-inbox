Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264082AbRFKXwc>; Mon, 11 Jun 2001 19:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264083AbRFKXwX>; Mon, 11 Jun 2001 19:52:23 -0400
Received: from paloma12.e0k.nbg-hannover.de ([62.159.219.12]:61181 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S264082AbRFKXwU>; Mon, 11 Jun 2001 19:52:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Keith Owens <kaos@ocs.com.au>
Subject: Re: 2.4.5-ac12: 3c590.c: Warning about 'nopnp' parameter
Date: Tue, 12 Jun 2001 02:02:14 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <10820.992234920@ocs4.ocs-net>
In-Reply-To: <10820.992234920@ocs4.ocs-net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010611235220Z264082-17720+2933@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 11. Juni 2001 06:48 schrieb Keith Owens:
> On Mon, 11 Jun 2001 04:35:42 +0200,
>
> Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de> wrote:
> >insmod: Warning: /lib/modules/2.4.5-ac12/kernel/drivers/net/3c509.o symbol
> >for parameter nopnp not found
>
> MODULE_PARM(nopnp) is in open code but the declaration of nopnp is
> wrapped in #ifdef CONFIG_ISAPNP.  The module parm needs to be wrapped
> in #ifdef CONFIG_ISAPNP as well.  Against 2.4.5-ac13.
>
> Index: 5.35/drivers/net/3c509.c
> --- 5.35/drivers/net/3c509.c Sat, 09 Jun 2001 17:17:16 +1000 kaos
> (linux-2.4/l/c/31_3c509.c 1.2.1.6 644) +++ 5.35(w)/drivers/net/3c509.c Mon,
> 11 Jun 2001 14:47:01 +1000 kaos (linux-2.4/l/c/31_3c509.c 1.2.1.6 644) @@
> -1014,8 +1014,10 @@ MODULE_PARM_DESC(debug, "EtherLink III d
>  MODULE_PARM_DESC(irq, "EtherLink III IRQ number(s) (assigned)");
>  MODULE_PARM_DESC(xcvr,"EtherLink III tranceiver(s) (0=internal,
> 1=external)"); MODULE_PARM_DESC(max_interrupt_work, "EtherLink III maximum
> events handled per interrupt"); +#ifdef CONFIG_ISAPNP
>  MODULE_PARM(nopnp, "i");
>  MODULE_PARM_DESC(nopnp, "EtherLink III disable ISA PnP support (0-1)");
> +#endif	/* CONFIG_ISAPNP */
>
>  int
>  init_module(void)

It calmed it.

Thanks,
	Dieter
