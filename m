Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318145AbSHLQUg>; Mon, 12 Aug 2002 12:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318707AbSHLQUg>; Mon, 12 Aug 2002 12:20:36 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24317 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318145AbSHLQUf>; Mon, 12 Aug 2002 12:20:35 -0400
Subject: Re: [PATCH] 2.4.19 revert block_llseek behavior to standard
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Phil Auld <pauld@egenera.com>
Cc: viro@math.psu.edu, marcelo@connectiva.com.br, linux-kernel@vger.kernel.org
In-Reply-To: <20020812120659.B27650@vienna.EGENERA.COM>
References: <20020812120659.B27650@vienna.EGENERA.COM>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Aug 2002 17:20:57 +0100
Message-Id: <1029169257.16424.176.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-12 at 17:06, Phil Auld wrote:
> Hi Al,
> 	I think this falls under the VFS umbrella, but I may be wrong. 
> 
> Below is a fix to make block_llseek behave as specified in the Single Unix Spec. v3.
> (http://www.unix-systems.org/single_unix_specification/). It's extremely trivial but
> may have political baggage.

Political I don't see any. Technical - have you verified each of our
block drivers behaves correctly when given an offset over its side, and
that it correctly fails on a 32bit block wrap.

I suspect we should still fail it with the allowed error code to be safe
in 2.4

