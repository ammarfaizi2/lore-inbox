Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261698AbSJ2JGE>; Tue, 29 Oct 2002 04:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261699AbSJ2JGE>; Tue, 29 Oct 2002 04:06:04 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:42194 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261698AbSJ2JGD>; Tue, 29 Oct 2002 04:06:03 -0500
Subject: Re: query: light weight TCP/IP stack for Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Amol Kumar Lad <amolk@ishoni.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <7CFD7CA8510CD6118F950002A519EA3001FE5748@leonoid.in.ishoni.com>
References: <7CFD7CA8510CD6118F950002A519EA3001FE5748@leonoid.in.ishoni.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Oct 2002 09:31:25 +0000
Message-Id: <1035883885.5852.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-29 at 04:40, Amol Kumar Lad wrote:
> Hi,
>   I am looking for a very light weight TCP/IP stack(small memory footprint)
> that I can hook in Linux (i.e. replace linux's native stack with new one).
> Are there any such stacks available ?? If yes, Is intergrating that stack in
> our kernel is seamless or I have to dig real hard in kernel to do that .

Assuming you can find another GPL licensable network stack (I know of
only two) then you are still going to have to deal with the fact the
core linux kernel networking interfaces are radically different to 4BSD
and/or something like ELKS. Probably much simpler is to just move to a
current 2.4 kernel with rmap patches, apply the uninline stuff to get
the size slightly down, then trim all the hash tables hard.

> Ps: I am using linux kernel 2.4.2 (please don't flame..)

You need to change that anyway. 2.4.2 has plenty of bugs as well as
security holes.



