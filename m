Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262446AbTANLpD>; Tue, 14 Jan 2003 06:45:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbTANLpD>; Tue, 14 Jan 2003 06:45:03 -0500
Received: from userel174.dsl.pipex.com ([62.188.199.174]:33673 "EHLO
	einstein31.homenet") by vger.kernel.org with ESMTP
	id <S262446AbTANLpB>; Tue, 14 Jan 2003 06:45:01 -0500
Date: Tue, 14 Jan 2003 11:54:52 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein31.homenet>
To: Christoph Hellwig <hch@lst.de>
cc: Hugh Dickins <hugh@veritas.com>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't create regular files in devfs (fwd)
In-Reply-To: <Pine.LNX.4.33.0301141145370.1241-100000@einstein31.homenet>
Message-ID: <Pine.LNX.4.33.0301141151560.1241-100000@einstein31.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

btw, I assumed that by "It" you meant the actual act of updating microcode
on cpus. If you were referring to the ability to manipulate microcode file
that I described, then "it" certainly does _not_ work if no devfs is
present.

Unless the world has been turned upside down and device nodes now have a
filesize stored somewhere? :)

Regards
Tigran

On Tue, 14 Jan 2003, Tigran Aivazian wrote:

> On Tue, 14 Jan 2003, Christoph Hellwig wrote:
>
> > On Tue, Jan 14, 2003 at 09:34:52AM +0000, Tigran Aivazian wrote:
> > > Hi Christoph,
> > >
> > > I don't know about mtrr (probably does it for the same reason) but the
> > > reason why microcode driver uses a regular file is because it needs
> > > something that only regular files can provide --- the file size.
> > >
> > > This is an easy external "signifier" as to whether a successfull microcode
> > > update has occurred or not.
> >
> > It seems to work without that feature on systems that don't have devfs..
>
> Of course it works without it. I never said it is a required feature, only
> a very nice to have. Namely:
>
> a) if devfs is available it provides a regular file whose size can be
> examined by applications and content read/written without much "fuss". In
> particular it is very convenient to say "vi microcode" and examine the
> content directly. If it was a device node then this would have been
> impossible.
>
> b) if devfs is not available then a limited basic functionality is
> provided --- i.e. just update the microcode on CPU(s) and write the log
> messages in the kernel log.
>
> Btw, having a size of mtrr is also useful for a similar reason.
>
> Regards
> Tigran
>
>

