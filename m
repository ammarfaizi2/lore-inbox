Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbRFZUhQ>; Tue, 26 Jun 2001 16:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263918AbRFZUhI>; Tue, 26 Jun 2001 16:37:08 -0400
Received: from www.wen-online.de ([212.223.88.39]:46087 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S262355AbRFZUgZ>;
	Tue, 26 Jun 2001 16:36:25 -0400
Date: Tue, 26 Jun 2001 22:35:45 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        <Paul.Russell@rustcorp.com.au>
Subject: Re: [PATCH] proc_file_read() (Was: Re: proc_file_read() question)
In-Reply-To: <Pine.LNX.4.30.0106261906240.13052-100000@biker.pdb.fsc.net>
Message-ID: <Pine.LNX.4.33.0106262133490.405-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2001, Martin Wilck wrote:

> Hi,
>
> > Shhh ;-)  Last time that hack was mentioned, someone wanted to _remove_
> > it.  It's a very nice little hack to have around, and IKD uses it.
>
> I am not saying it should be removed. But IMO it is a legitimate (if
> not the originally intended) use of "start" to serve as a pointer to
> a memory area allocated in the proc_read () function. This use is broken
> with this hack in its current form, because reading from such a file
> will fail depending on the (random) order of the page and start pointers.
>
> If I understand the "hack" right, legitimate offsets generated for it
> are always between 0 and PAGE_SIZE. Therefore the patch below would
> not break it, while overcoming the abovementioned problem, because
> legitimate page pointers will never be < PAGE_SIZE.

It's dead simple.  My variable length data often didn't quite fit into
the transport vehicle.. so I whacked the excess to avoid the fault.

	-Mike

