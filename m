Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317013AbSEWVZh>; Thu, 23 May 2002 17:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317014AbSEWVZg>; Thu, 23 May 2002 17:25:36 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:46857 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S317013AbSEWVZf>; Thu, 23 May 2002 17:25:35 -0400
Date: Thu, 23 May 2002 17:27:13 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andries.Brouwer@cwi.nl, Alan Cox <alan@lxorguk.ukuu.org.uk>, hpa@zytor.com,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: IO stats in /proc/partitions
In-Reply-To: <20020516085022.B14643@infradead.org>
Message-ID: <Pine.LNX.4.21.0205231723450.3295-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 May 2002, Christoph Hellwig wrote:

> On Wed, May 15, 2002 at 06:39:03PM -0300, Marcelo Tosatti wrote:
> > > On the other hand, disk statistics should not be in
> > > /proc/partitions. They should be in /proc/diskstatistics.
> > > I see a heading today "rio rmerge rsect ruse wio wmerge"
> > > "wsect wuse running use aveq". No doubt next year we'll
> > > want different statistics. So /proc/diskstatistics should
> > > start with a header line including a version field.
> > > 
> > > Please keep these disk statistics apart from /proc/partitions.
> > 
> > The change can possibly break userlevel tools which were working with
> > 2.4.18.
> > 
> > Christoph, please create a /proc/diskstatistics file or something like
> > that and send me a patch.
> 
> I rather send a complete backout patch for mainline instead.  This format
> has been used by the vendor (Red Hat, SuSE, etc..) kernels since 2.2 ages
> and is used (if present) by the stock performance tools for linux
> (i.e. syststat package, iostats

Look, I just do not want to break some apps which read /proc/partitions.
Thats it.

Look, changing the userlevel apps to at least know about the new format is
not hard. And you can do that over time.

Do you see why I think /proc/whatever-else is interesting ?


