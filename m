Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264146AbRFLDJT>; Mon, 11 Jun 2001 23:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264157AbRFLDJJ>; Mon, 11 Jun 2001 23:09:09 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46345 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264146AbRFLDJG>; Mon, 11 Jun 2001 23:09:06 -0400
Date: Mon, 11 Jun 2001 22:33:38 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Didier CONTIS <didier@ece.gatech.edu>
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
Subject: Re: Pb of __alloc_pages
In-Reply-To: <GGEBJOIKMBAKLHABNEAPCEJCCDAA.didier@ece.gatech.edu>
Message-ID: <Pine.LNX.4.21.0106112227550.6617-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 11 Jun 2001, Didier CONTIS wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I am building a Beowulf cluster using Dell PowerEdge 1400SC
> (2x800Mhz, 1GB of ram, 9GB Ultra160) and using kernel 2.4.5
> 
> I several of my nodes I am getting the following errors:
> 
> Jun 10 00:19:32 grendel16 kernel: __alloc_pages: 0-order allocation
> failed.
> Jun 10 00:19:32 grendel16 last message repeated 12 times
> Jun 10 00:19:36 grendel16 kernel: ed.
> Jun 10 00:19:36 grendel16 kernel: __alloc_pages: 0-order allocation
> failed.
> Jun 10 00:19:55 grendel16 last message repeated 363 times
> Jun 10 00:23:32 grendel16 kernel: VFS: file-max limit 8192 reached
> 
> Below is the output of cat /proc/slabinfo
> 
> I was wondering if someone could help me debug this one.
> 
> Thanks in advance for any help,

Could you please try 2.4.6pre1 or higher? 

Since you seem to have an IO intensive workload (right?), pre1 should
throttle those IO allocations and avoid the extreme memory shortage. 

Thanks 

