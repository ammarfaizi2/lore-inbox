Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262778AbSJCLBu>; Thu, 3 Oct 2002 07:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263386AbSJCLBu>; Thu, 3 Oct 2002 07:01:50 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:54430 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262778AbSJCLBt>;
	Thu, 3 Oct 2002 07:01:49 -0400
Date: Thu, 3 Oct 2002 07:07:21 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: initrd breakage in 2.5.38-2.5.40
In-Reply-To: <15772.9013.244887.809979@kim.it.uu.se>
Message-ID: <Pine.GSO.4.21.0210030702500.13480-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Oct 2002, Mikael Pettersson wrote:

> First I thought the problem was caused by a apparently missing
> set_capacity() call in 2.5.38's drivers/block/rd.c:

I _really_ doubt it - check the loop just above the add_disk() one.
set_capacity() call is done there, repeating it won't change anything.

