Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbTBJWSw>; Mon, 10 Feb 2003 17:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbTBJWR5>; Mon, 10 Feb 2003 17:17:57 -0500
Received: from quechua.inka.de ([193.197.184.2]:39404 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S265385AbTBJWRV>;
	Mon, 10 Feb 2003 17:17:21 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Setjmp/Longjmp in the kernel?
References: <20030209221044.GA8761@morningstar.nowhere.lie> <1044882041.418.1.camel@irongate.swansea.linux.org.uk>
Organization: private Linux site, southern Germany
Date: Mon, 10 Feb 2003 23:24:41 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E18iMLx-00020k-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> int foo_func()
> {
> 	alloc this
> 	alloc that
> 	_foo_func()
> 	free this
> 	free that
> }

Not that this matters any bit, but the proper order is of course
 	alloc this
 	alloc that
 	_foo_func()
 	free that
 	free this

even if only for aesthetical reasons :-)

(with locks, it does matter...)

Olaf

