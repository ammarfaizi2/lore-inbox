Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262554AbSJGTTn>; Mon, 7 Oct 2002 15:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262561AbSJGTTn>; Mon, 7 Oct 2002 15:19:43 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11014 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262554AbSJGTTm>; Mon, 7 Oct 2002 15:19:42 -0400
Date: Mon, 7 Oct 2002 12:24:36 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@digeo.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Oliver Neukum <oliver@neukum.name>, Rob Landley <landley@trommello.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not
 3.0 -  (NUMA))
In-Reply-To: <E17ydBs-0003uE-00@starship>
Message-ID: <Pine.LNX.4.33.0210071222340.10168-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 Oct 2002, Daniel Phillips wrote:
> 
> Devices have a few MB of readahead cache, the kernel can have thousands of
> times as much.

I don't think that is in the least realistic.

There's _no_ way that the krenel could do physical readahead for more than
a few tens or hundreds of kB - the latency impact would just be too much
to handle, and the VM impact is not likely insignificant either.

So the device readahead is _not_ noticeably smaller than what the kernel
can reasonably do, and it does a better job of it (ie disks can fill track
buffers optimally, depending on where the head hits etc).

		Linus

