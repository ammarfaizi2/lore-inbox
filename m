Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422851AbWANHuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422851AbWANHuj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 02:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422925AbWANHuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 02:50:39 -0500
Received: from xproxy.gmail.com ([66.249.82.205]:44959 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422851AbWANHuj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 02:50:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AtL9NWMNUfMA9Mu23+wXkmPB/QMv3ilCX9qw/p+fTgH5HxJuptnGYFmhgtNMnH7MA6oGEDav1K/1zVr2esU44y9XzBP3t/UA1H1AiORGmrwKxY046WtaTpWAriYALpxE8WETJ8ESUZjOyZCPqSf+AYxd1FW1ZkUBnpW85PkIoP0=
Message-ID: <4807377b0601132350y41c47d3bpb46b7b9af3690038@mail.gmail.com>
Date: Fri, 13 Jan 2006 23:50:38 -0800
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: gcoady@gmail.com
Subject: Re: 2.4: e100 accounting bust for multiple adapters
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <53pgs11trhj0f6ik29hk41n4p5fegbft55@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <e196s1pj6u4apbjhgdm3imij4a10s6nb87@4ax.com>
	 <4807377b0601101624m1e1eb636q99ae0792b0903c5a@mail.gmail.com>
	 <cln8s1diqmsei30gqo0dbuv1hclgl4m2lu@4ax.com>
	 <4807377b0601112059je92091ch73f3788aeca452ce@mail.gmail.com>
	 <53pgs11trhj0f6ik29hk41n4p5fegbft55@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/06, Grant Coady <gcoady@gmail.com> wrote:
> On Wed, 11 Jan 2006 20:59:50 -0800, Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:
>
> >> Anyway the solution is simple: modular e100 is borked on 2.4,
> >> compiled in is okay.
> >
> >modular e100 2.X is borked, right? if you have a moment could you try
> >the 3.X e100 driver from sourceforge?
> >(http://prdownloads.sf.net/e1000) it should work fine on 2.4 and I
> >haven't heard any reports of icky stats.
>
> Hi Jesse,
>
> Couple of compile warnings:
> grant@deltree:~/e100-3.5.10/src$ make clean; make CFLAGS_EXTRA=-DE100_NO_NAPI
> rm -rf e100.o e100.o e100.o e100.o e100.o e100.7.gz .*cmd .tmp_versions
> gcc -DLINUX -D__KERNEL__ -DMODULE -O2 -pipe -Wall -I/lib/modules/2.4.32-hf32.1x/build/include -I. -DMODVERSIONS -DEXPORT_SYMTAB -include /lib/modules/2.4.32-hf32.1x/build/include/linux/modversions.h -DE100_NO_NAPI   -c -o e100.o e100.c
> In file included from /lib/modules/2.4.32-hf32.1x/build/include/linux/spinlock.h:6,
>                  from /lib/modules/2.4.32-hf32.1x/build/include/linux/module.h:12,
>                  from e100.c:138:
> /lib/modules/2.4.32-hf32.1x/build/include/asm/system.h: In function `__set_64bit_var':
> /lib/modules/2.4.32-hf32.1x/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
> /lib/modules/2.4.32-hf32.1x/build/include/asm/system.h:190: warning: dereferencing type-punned pointer will break strict-aliasing rules
>

I'm not sure but I don't think those warnings are from something e100
can control.

> **************************************************
> ** e100.o built for 2.4.32-hf32.1x
> ** SMP               Disabled
> **************************************************
>
> I have e100-3.5.10 up now and the stats now look okay.  Is this
> driver update headed for 2.4 kernel inclusion?

Most people running 2.4 seem to be okay with the old driver.  We
haven't maintained it for a long time, and have moved all of our
efforts to the more maintainable (rewritten) 3.X driver.  Basically
we've taken the position that 2.4 is legacy and if it ain't broke
don't fix it.

well, you've found something that broke, but maybe someone on list
here can help with a fix, but to answer your question its unlikely
that we'll attempt to rev the 2.4 driver unless something very serious
is brought up.

I'm hoping you can get along with the 3.X driver, and I'll be glad to
look into any issues that you come up with for that driver.

Jesse
