Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290704AbSAYPVs>; Fri, 25 Jan 2002 10:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290706AbSAYPVj>; Fri, 25 Jan 2002 10:21:39 -0500
Received: from nat-pool-meridian.redhat.com ([12.107.208.200]:46952 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S290704AbSAYPVZ>; Fri, 25 Jan 2002 10:21:25 -0500
Date: Fri, 25 Jan 2002 10:21:14 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Werner Almesberger <wa@almesberger.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020125102114.T10157@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <200201242141.g0OLfjL06681@home.ashavan.org.> <Pine.LNX.4.44.0201241545120.2839-100000@waste.org> <a2q1d8$vuj$1@cesium.transmeta.com> <20020125160750.A18035@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020125160750.A18035@almesberger.net>; from wa@almesberger.net on Fri, Jan 25, 2002 at 04:07:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 04:07:50PM +0100, Werner Almesberger wrote:
> H. Peter Anvin wrote:
> > c) The ability to cast to bool and get an unambiguous true or false:
> > 
> >      b = (bool)a;
> > 
> >    This replaces the idiomatic but occationally confusing
> > 
> >      b = !!a;
> 
> Careful, though. This example
> 
> #include <stdbool.h>
> #include <stdio.h>
> 
> int main(void)
> {
>     int foo;
> 
>     foo = (bool) 4;
>     printf("%d\n",foo);
>     return 0;
> }
> 
> e.g. compiled with gcc "2.96" (RH 7.1, 2.96-85), yields 4.

Yeah, _Bool builtin type was added to gcc 2000-11-13, ie. after 2.96-RH was
branched. It yields 1 in gcc 3.0 or 3.1 CVS though.

	Jakub
