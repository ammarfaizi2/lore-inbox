Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312480AbSDELsq>; Fri, 5 Apr 2002 06:48:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312484AbSDELsh>; Fri, 5 Apr 2002 06:48:37 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:24989 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S312480AbSDELs3>;
	Fri, 5 Apr 2002 06:48:29 -0500
Date: Fri, 5 Apr 2002 06:48:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Jurriaan on Alpha <thunder7@xs4all.nl>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre6 doesn't compile on Alpha
In-Reply-To: <20020405105409.GA29804@alpha.of.nowhere>
Message-ID: <Pine.GSO.4.21.0204050636100.25849-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Apr 2002, Jurriaan on Alpha wrote:

> init/do_mounts.c:45: parse error before `mount_initrd'
[snip]

Looks like a missing init.h - sorry, this sucker didn't get caught (on
x86 slab.h ends up pulling it in, on alpha it doesn't).

Fix: add #include <linux/init.h> in init/do_mounts.c

