Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266183AbUFPGXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266183AbUFPGXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 02:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266185AbUFPGXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 02:23:30 -0400
Received: from pdbn-d9bb9ea9.pool.mediaWays.net ([217.187.158.169]:35590 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S266183AbUFPGX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 02:23:28 -0400
Date: Wed, 16 Jun 2004 08:21:54 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: Paul Jackson <pj@sgi.com>
Cc: aoliva@redhat.com, cesarb@nitnet.com.br, linux-kernel@vger.kernel.org,
       viro@math.psu.edu
Subject: Re: [PATCH] O_NOATIME support
Message-ID: <20040616062154.GA28366@citd.de>
References: <20040612011129.GD1967@flower.home.cesarb.net> <orpt81sv1g.fsf@free.redhat.lsd.ic.unicamp.br> <20040614224006.GD1961@flower.home.cesarb.net> <orfz8wabng.fsf@free.redhat.lsd.ic.unicamp.br> <20040615193205.GA25131@citd.de> <20040615150349.352b9fb1.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040615150349.352b9fb1.pj@sgi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2004 at 03:03:49PM -0700, Paul Jackson wrote:
> Matthias, replying to Alexandre:
> > > But utimes updates the inode modification time, so you can still tell
> > > something happened to the file.
> > 
> > No.
> 
> A less terse answer:
> 
>   Utimes modifies the inode ctime - time of last inode change.
> 
> So, yes, you can still something happened to the file.

Hmm. The man-page doesn't meantion this, but i tried it

stat <file>
touch <file>
stat <file>

and all 3 times were the same after touching it.

man touch
- snip -
       Update the access and modification times of each FILE to the current time.
- snip -

I would have guessed that changing atime/mtime doesn't change ctime.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

