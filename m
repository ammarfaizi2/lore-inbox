Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262033AbSI3ME6>; Mon, 30 Sep 2002 08:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262034AbSI3ME6>; Mon, 30 Sep 2002 08:04:58 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:60153 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262033AbSI3ME5>; Mon, 30 Sep 2002 08:04:57 -0400
Subject: Re: NatSemi SCx200 patches for Linux-2.5
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christer Weinigel <christer@weinigel.se>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <87d6qvyb4c.fsf@zoo.weinigel.se>
References: <87d6qvyb4c.fsf@zoo.weinigel.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 13:16:56 +0100
Message-Id: <1033388216.16266.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 12:23, Christer Weinigel wrote:
> How can I guarantee that the driver scx200.c is initialized before any
> other drivers that use the scx200_gpio functions (e.g. scx200_i2c.c)?
> I have put scx200.c in in arch/i386/kernel in the hope that this
> directory will always be initialized before anything else, but is this
> really true?

There are two ways. For built in code you can use the link order to
force ordering. In 2.4 thats your only real choice. For modules you need
to ensure there is a dependancy so modprobe loads the supporting module
first

Alan

