Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSHMIHm>; Tue, 13 Aug 2002 04:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314680AbSHMIHm>; Tue, 13 Aug 2002 04:07:42 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:49170 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S314149AbSHMIHm>; Tue, 13 Aug 2002 04:07:42 -0400
Message-ID: <3D58BF9A.94ECD8A6@aitel.hist.no>
Date: Tue, 13 Aug 2002 10:13:14 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.31 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19 revert block_llseek behavior to standard
References: <20020812120659.B27650@vienna.EGENERA.COM> <20020812174634.A10106@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Mon, Aug 12, 2002 at 12:06:59PM -0400, Phil Auld wrote:
> > Hi Al,
> >       I think this falls under the VFS umbrella, but I may be wrong.
> >
> > Below is a fix to make block_llseek behave as specified in the Single Unix Spec. v3.
> > (http://www.unix-systems.org/single_unix_specification/). It's extremely trivial but
> > may have political baggage.
> 
> Have you tested when you actually seek over the size of a block device?
> Stupid standards aside: what is the purpose of this?  blockdevices won't
> grow bigger if you seek beyond them..
> 
True for a disk - but will all blockdevices be
like that forever?
Extending a ram disk might be useful.  Or something
looped to a regular file.  

Helge Hafting
