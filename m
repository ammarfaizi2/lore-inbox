Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289842AbSBSUc1>; Tue, 19 Feb 2002 15:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289876AbSBSUcT>; Tue, 19 Feb 2002 15:32:19 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:15285 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289849AbSBSUbY>;
	Tue, 19 Feb 2002 15:31:24 -0500
Date: Tue, 19 Feb 2002 15:31:21 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ENOTTY from ext3 code?
In-Reply-To: <20020219190932.GA274@elf.ucw.cz>
Message-ID: <Pine.GSO.4.21.0202191528360.9938-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Feb 2002, Pavel Machek wrote:

> Hi!
> 
> ext3/ioctl.c:
> 
> ...
> 	return -ENOTTY;
> 
> Does it really make sense to return "not a typewriter" from ext3
> ioctl?

s/typewriter/teletype/ and ext3 indeed is not one (and thus shouldn't _have_ 
ioctl() in the first place).  Seriously, -ENOTTY is normal error for "I don't
know anything about that ioctl".

