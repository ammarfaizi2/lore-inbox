Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316619AbSFLLpi>; Wed, 12 Jun 2002 07:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSFLLph>; Wed, 12 Jun 2002 07:45:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44550 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316619AbSFLLpg>;
	Wed, 12 Jun 2002 07:45:36 -0400
Date: Wed, 12 Jun 2002 12:45:36 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Saurabh Desai <sdesai@austin.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/locks.c: Fix posix locking for threaded tasks
Message-ID: <20020612124536.T27449@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20020610034843.W27186@parcelfarce.linux.theplanet.co.uk> <E17I4bn-0007Rn-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 10:40:07AM +0100, Alan Cox wrote:
> > SUS v3 does not offer any enlightenment.  But it seems reasonable that
> > processes which share a files_struct should share locks.  After all,
> > if one process closes the fd, they'll remove locks belonging to the
> > other process.
> > 
> > Here's a patch generated against 2.4; it also applies to 2.5.
> > Please apply.
> 
> This seems horribly inappropriate for 2.4 as it may break apps

I have no problem with withdrawing the request for 2.4.  It does mean that
it's almost impossible to write an M:N threading library implementation.
This doesn't concern me too much; I just want you to be aware this is
the tradeoff you're making.

I would still like to see it in 2.5.

-- 
Revolutions do not require corporate support.
