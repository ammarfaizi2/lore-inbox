Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316599AbSEPHwR>; Thu, 16 May 2002 03:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316600AbSEPHwQ>; Thu, 16 May 2002 03:52:16 -0400
Received: from imladris.infradead.org ([194.205.184.45]:14 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S316599AbSEPHwP>; Thu, 16 May 2002 03:52:15 -0400
Date: Thu, 16 May 2002 08:50:22 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andries.Brouwer@cwi.nl, Alan Cox <alan@lxorguk.ukuu.org.uk>, hpa@zytor.com,
        lkml <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: IO stats in /proc/partitions
Message-ID: <20020516085022.B14643@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, Andries.Brouwer@cwi.nl,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, hpa@zytor.com,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <UTC200205041959.g44JxQa20044.aeb@smtp.cwi.nl> <Pine.LNX.4.21.0205151838001.21222-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 06:39:03PM -0300, Marcelo Tosatti wrote:
> > On the other hand, disk statistics should not be in
> > /proc/partitions. They should be in /proc/diskstatistics.
> > I see a heading today "rio rmerge rsect ruse wio wmerge"
> > "wsect wuse running use aveq". No doubt next year we'll
> > want different statistics. So /proc/diskstatistics should
> > start with a header line including a version field.
> > 
> > Please keep these disk statistics apart from /proc/partitions.
> 
> The change can possibly break userlevel tools which were working with
> 2.4.18.
> 
> Christoph, please create a /proc/diskstatistics file or something like
> that and send me a patch.

I rather send a complete backout patch for mainline instead.  This format
has been used by the vendor (Red Hat, SuSE, etc..) kernels since 2.2 ages
and is used (if present) by the stock performance tools for linux
(i.e. syststat package, iostat).


