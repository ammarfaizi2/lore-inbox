Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312558AbSGYUAq>; Thu, 25 Jul 2002 16:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315456AbSGYUAq>; Thu, 25 Jul 2002 16:00:46 -0400
Received: from waste.org ([209.173.204.2]:21634 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S312558AbSGYUAp>;
	Thu, 25 Jul 2002 16:00:45 -0400
Date: Thu, 25 Jul 2002 15:03:46 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Erik Andersen <andersen@codepoet.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, Andreas Dilger <adilger@clusterfs.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Header files and the kernel ABI
In-Reply-To: <20020725181923.GA4858@codepoet.org>
Message-ID: <Pine.LNX.4.44.0207251455460.17906-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jul 2002, Erik Andersen wrote:

> On Thu Jul 25, 2002 at 09:31:23AM -0700, H. Peter Anvin wrote:
> > Oliver Xymoron wrote:
> > >
> > >Ideally, the ABI layer would be maintained and packaged separately from
> > >both the kernel and glibc to avoid gratuitous changes from either side.
> > >
> >
> > I disagree.  The ABI is a product of the kernel and should be attached
> > to it.  It is *not* a product of glibc -- glibc is a consumer of it, as
> > are any other libcs.
>
> Agreed.  I maintain a libc and I certainly do not want to
> have to maintain the kernel ABI of the day headers.  That
> is clearly a job for the kernel.

The idea of maintaining them separately is that people won't be able to
touch the ABI without explicitly going through a gatekeeper whose job is
to minimize breakage. Linus usually catches ABI changes but not always.

I explicitly did _not_ suggest making it the job of libc maintainers. And
the whole point of the exercise is to avoid ABI of the day anyway. The ABI
should change less frequently than the kernel or libc. It's more analogous
to something like modutils.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

