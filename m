Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbVJHT3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbVJHT3W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 15:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbVJHT3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 15:29:22 -0400
Received: from agmk.net ([217.73.31.34]:45586 "EHLO mail.agmk.net")
	by vger.kernel.org with ESMTP id S1751103AbVJHT3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 15:29:21 -0400
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@agmk.net>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: [2.6] binfmt_elf bug (exposed by klibc).
Date: Sat, 8 Oct 2005 21:29:13 +0200
User-Agent: KMail/1.8.2
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
References: <200510071533.j97FX9Wp018589@laptop11.inf.utfsm.cl> <200510080042.58408.pluto@agmk.net> <20051008143014.GX14750@lug-owl.de>
In-Reply-To: <20051008143014.GX14750@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200510082129.13955.pluto@agmk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia sobota, 8 października 2005 16:30, Jan-Benedict Glaw napisał:
> On Sat, 2005-10-08 00:42:58 +0200, Paweł Sikora <pluto@agmk.net> wrote:
> > > Did somebody accidentally
> > > screw up some kernel code between 2.6.13 and 2.6.14?
> >
> > I think kernel elf loader doesn't handle binaries without .bss.
> > Earlier binutils (<2.16) emits zero-sized .data/.bss and problem
> > wasn't exposed. Modern binutils doesn't emit useless zero-sized
> > .data/.bss sections and kernel kills these binaries.
>
> I had this problem at some time, too. This was when I started to redo
> the uClibc port to vax-linux, which I started with a hand-crafted
> assembly file. It also crashed upon execution, though I was sure the
> program was technically okay.

I think kernel wrongly assumes that all binaries in the world have
.text and at least .data/.bss. E.g. in embedded world software are
often pure, minimalistic and technically okay.

-- 
The only thing necessary for the triumph of evil
  is for good men to do nothing.
                                           - Edmund Burke
