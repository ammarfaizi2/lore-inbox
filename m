Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311600AbSCXRjk>; Sun, 24 Mar 2002 12:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311603AbSCXRja>; Sun, 24 Mar 2002 12:39:30 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:30419 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S311600AbSCXRjV>;
	Sun, 24 Mar 2002 12:39:21 -0500
Date: Sun, 24 Mar 2002 12:39:12 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Stevie O <stevie@qrpff.net>
cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [patch 2.5] seq_file for /proc/partitions
In-Reply-To: <5.1.0.14.2.20020324122756.02581750@whisper.qrpff.net>
Message-ID: <Pine.GSO.4.21.0203241238400.8504-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Mar 2002, Stevie O wrote:

> At 11:11 PM 3/23/2002 -0500, Alexander Viro wrote:
> >> +     return part_start(part, pos);
> >
> >Erm...  Actually that _is_ wrong - what you want is
> >
> >        return ((struct gendisk)v)->next;
> 
> Forgive my ignorance, but that doesn't look right....
> shouldn't it REALLY be
> 
>         return ((struct gendisk*)v)->next;

Grr...  Yes, indeed - sorry about a typo.

