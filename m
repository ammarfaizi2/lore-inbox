Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSEaNXN>; Fri, 31 May 2002 09:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSEaNXM>; Fri, 31 May 2002 09:23:12 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:7165 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315275AbSEaNXM>; Fri, 31 May 2002 09:23:12 -0400
Subject: Re: do_mmap
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.05.10205311456070.10633-100000@mausmaki.cosy.sbg.ac.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 31 May 2002 15:27:23 +0100
Message-Id: <1022855243.12888.410.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-31 at 14:00, Thomas 'Dent' Mirlacher wrote:
> and the checks in various places are really strange. - well some
> places check for:
> 	o != NULL
> 	o > -1024UL

"Not an error". Its relying as some other bits of code do actually that
the top mappable user address is never in the top 1K of the address
space

> is it possible to have 0 as a valid address? - if not, this should
> be the return on errors.

SuS explicitly says that 0 is not a valid mmap return address.

