Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264806AbSJVTwG>; Tue, 22 Oct 2002 15:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261657AbSJVTwG>; Tue, 22 Oct 2002 15:52:06 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:10776 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S264806AbSJVTv7>;
	Tue, 22 Oct 2002 15:51:59 -0400
Date: Tue, 22 Oct 2002 21:58:07 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre11 /proc/partitions read
Message-ID: <20021022195807.GA26620@win.tue.nl>
References: <20021022185958.GB26585@win.tue.nl> <Pine.LNX.4.44L.0210221625440.27942-100000@freak.distro.conectiva> <20021022193226.GC26585@win.tue.nl> <20021022203504.A7770@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021022203504.A7770@infradead.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 08:35:04PM +0100, Christoph Hellwig wrote:

> Both of those should be fixed by my patch, i.e. were caused by a bug
> in fpos handling in the seq_file /proc/partitions.  There is nothing
> about the statistics in them.

True. I quoted these references (i) because they are readily available,
and (ii) because they show problems with the file changing contents while
it is being read.
These two references predate your 2.4.19 patch - they are about a
Redhat-private kernel that already had these disk statistics.

The default 1K buffer was not large enough. Some utilities have now
been patched to tell stdio to use a 16K buffer. We won't have to wait
long before also that will turn out to be insufficient.

It is bad that one has to patch mount and the ext2 utilities and fdisk
and I don't know what other programs because some irrelevant (to mount etc.)
and changing stuff was added to /proc/partitions.

Andries

