Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290705AbSAYPIh>; Fri, 25 Jan 2002 10:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290704AbSAYPI1>; Fri, 25 Jan 2002 10:08:27 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:18445 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S290702AbSAYPIM>;
	Fri, 25 Jan 2002 10:08:12 -0500
Date: Fri, 25 Jan 2002 16:07:50 +0100
From: Werner Almesberger <wa@almesberger.net>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
Message-ID: <20020125160750.A18035@almesberger.net>
In-Reply-To: <200201242141.g0OLfjL06681@home.ashavan.org.> <Pine.LNX.4.44.0201241545120.2839-100000@waste.org> <a2q1d8$vuj$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2q1d8$vuj$1@cesium.transmeta.com>; from hpa@zytor.com on Thu, Jan 24, 2002 at 02:21:28PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> c) The ability to cast to bool and get an unambiguous true or false:
> 
>      b = (bool)a;
> 
>    This replaces the idiomatic but occationally confusing
> 
>      b = !!a;

Careful, though. This example

#include <stdbool.h>
#include <stdio.h>

int main(void)
{
    int foo;

    foo = (bool) 4;
    printf("%d\n",foo);
    return 0;
}

e.g. compiled with gcc "2.96" (RH 7.1, 2.96-85), yields 4.

Not sure if this is a flaw of gcc or of the standard. If gcc's
stdbool.h is a standard-compliant implementation of "bool", then
K&Rv2 seems to endorse this behaviour: from A4.2, "Enumerations
behave like integers".

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Lausanne, CH                    wa@almesberger.net /
/_http://icawww.epfl.ch/almesberger/_____________________________________/
