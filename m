Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbVJDCuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbVJDCuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 22:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVJDCuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 22:50:20 -0400
Received: from web35513.mail.mud.yahoo.com ([66.163.179.137]:28040 "HELO
	web35513.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932306AbVJDCuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 22:50:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=hd5sK4QIV5nuHpcDN4YNlvuYHe8MEvI03aIejvFgVL+Oq9o37KsOXkDjv6c6j67J50QjWgqGPhiQy8dhtuvXXWba7YLlunZkPNoxcOXzjiH/SiPzuhXPmmWtbx7q/WB0K75mXg1hEwL/fmhN/lr8DsvlYnHYNcFv4MLtWXujC8M=  ;
Message-ID: <20051004025016.78963.qmail@web35513.mail.mud.yahoo.com>
Date: Mon, 3 Oct 2005 19:50:16 -0700 (PDT)
From: Dan C Marinescu <dan_c_marinescu@yahoo.com>
Subject: Re: make xconfig fails for older kernels
To: "Randy.Dunlap" <rdunlap@xenotime.net>, Felix Oxley <lkml@oxley.org>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051003192728.5f0c11c7.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make oldconfig, menuconfig, gconfig work fine with me
(_but_ using a 2.6.13.2 .config -- so the jump is
smaller...)
make xconfig gives me troubles 2 (static parser...)
another way to go would be to explicitly save your old
(2.6.4) .config into something like .config-randy...
then consume it... (xconfig will not find a .config /
implicitly work, then you fool it by loading
.config-randy) that _should_ do it... if still not
working, mrproper the old 6.4 then goto
.config-randy... my $.02


   daniel



--- "Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> On Tue, 4 Oct 2005 02:13:03 +0100 Felix Oxley wrote:
> 
> > 
> > I have downloaded 2.6.0 + patches up to 2.6.13
> from kernel.org.
> > 
> > When I try to configure the kernel using 'make
> xconfig' I get the following 
> > error:
> > 
> > scripts/kconfig/mconf.c:91: error: static
> declaration of ___current_menu___ 
> > follows non-static declaration
> > scripts/kconfig/lkc.h:63: error: previous
> declaration of ___current_menu___ was 
> > here
> > make[1]: *** [scripts/kconfig/mconf.o] Error 1
> > make: *** [xconfig] Error 2
> > 
> > I attempted make menuconfig, make config, and make
> oldconfig but each failed 
> > with the same error,
> > 
> > This happens on 2.6.0, 2.6.1, 2.6.2 2.6.3, 2.6.4.
> > I have previously built newer kernels such as
> 2.6.13-rc2-rt7 without a 
> > problem.
> > 
> > I was able to overcome the error by commenting out
> the declaration of 
> > current_menu in mconf.c. But I am concerned as to
> the cause of this problem.
> > 
> > Does anyone have an explanation?
> 
> Sorry, not really, other than to say that make
> menuconfig and
> make xconfig work fine for me on 2.6.4.
> I just downloaded the 2.6.4 tarball and
> tested/verified them.
> 
> ---
> ~Randy
> You can't do anything without having to do something
> else first.
> -- Belefant's Law
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
