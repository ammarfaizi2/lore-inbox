Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292975AbSBVTq4>; Fri, 22 Feb 2002 14:46:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292968AbSBVTqE>; Fri, 22 Feb 2002 14:46:04 -0500
Received: from bitmover.com ([192.132.92.2]:29838 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S292969AbSBVTpX>;
	Fri, 22 Feb 2002 14:45:23 -0500
Date: Fri, 22 Feb 2002 11:45:22 -0800
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Larry McVoy <lm@bitmover.com>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Christoph Hellwig <hch@caldera.de>, hpa@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 bitkeeper repository
Message-ID: <20020222114522.G7909@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>, Larry McVoy <lm@bitmover.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Christoph Hellwig <hch@caldera.de>, hpa@kernel.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020222104232.D28253@work.bitmover.com> <Pine.LNX.4.33L.0202221634230.7820-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L.0202221634230.7820-100000@imladris.surriel.com>; from riel@conectiva.com.br on Fri, Feb 22, 2002 at 04:37:27PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 04:37:27PM -0300, Rik van Riel wrote:
> On Fri, 22 Feb 2002, Larry McVoy wrote:
> 
> > On Fri, Feb 22, 2002 at 02:36:39PM -0200, Marcelo Tosatti wrote:
> > > As soon as I have time, I'll learn BK and maintain the repository myself.
> 
> > Also, if you want, one of us can get on IRC while you are walking the
> > demo and answer your questions.
> 
> I've already promised marcelo to setup some repositories,
> one with Jeff's marcelo-2.4 tree and a few with patches
> to merge into 2.4.
> 
> Then I'll walk marcelo through the process of merging
> patches with bitkeeper (or rather, letting bitkeeper take
> care of that stuff) and generally making marcelo familiar
> with the important bitkeeper commands and some external
> scripts.

The main thing is that you need to watch out for renames in patches.
bk import -tpatch handles that, straight patch does not.  If you don't
catch the renames life will suck because one file will be deleted in
your tree but may not be deleted yet in another tree.  If someone else 
is working on the old tree and you pull from them, their updates will
go to the deleted file.  They are there, but pretty useless if you 
wanted them in the file with the new name.

We need to tweak stuff so that you can use bk import -temail or something
like that and it's a combination of Linus' scripts and the current code.
Linus?  Scripts?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
