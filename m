Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316510AbSEOWjV>; Wed, 15 May 2002 18:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316511AbSEOWjV>; Wed, 15 May 2002 18:39:21 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61701 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S316510AbSEOWjU>; Wed, 15 May 2002 18:39:20 -0400
Date: Wed, 15 May 2002 18:39:03 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andries.Brouwer@cwi.nl
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, hpa@zytor.com,
        lkml <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: IO stats in /proc/partitions
In-Reply-To: <UTC200205041959.g44JxQa20044.aeb@smtp.cwi.nl>
Message-ID: <Pine.LNX.4.21.0205151838001.21222-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 May 2002 Andries.Brouwer@cwi.nl wrote:

> Earlier I noticed that RedHat did put some statistics in
> /proc/partitions. That was bad, but I assumed that it was
> their laziness, being too busy to do a proper job.
> 
> However, I see that these days the pollution of /proc/partitions
> is becoming official - it is part of patch-2.4.19-pre7.
> I strongly object, and hope it is not too late to revert this.
> 
> Things must do one thing, and one thing well.
> The task of /proc/partitions is to list which partitions the
> kernel knows about. When I implemented it I thought that adding
> the starting offset would be superfluous, but in fact I now realize
> that that is required for several applications.
> So, /proc/partitions must be updated sooner or later with an
> additional field "starting offset". Possibly more fields to
> enable identification. Sometimes it is really difficult to
> determine which Linux name belongs to which hardware device,
> especially with USB.
> 
> On the other hand, disk statistics should not be in
> /proc/partitions. They should be in /proc/diskstatistics.
> I see a heading today "rio rmerge rsect ruse wio wmerge"
> "wsect wuse running use aveq". No doubt next year we'll
> want different statistics. So /proc/diskstatistics should
> start with a header line including a version field.
> 
> Please keep these disk statistics apart from /proc/partitions.

The change can possibly break userlevel tools which were working with
2.4.18.

Christoph, please create a /proc/diskstatistics file or something like
that and send me a patch.

Thanks.

