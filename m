Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269952AbRHENCb>; Sun, 5 Aug 2001 09:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269953AbRHENCV>; Sun, 5 Aug 2001 09:02:21 -0400
Received: from mail.zmailer.org ([194.252.70.162]:55056 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S269952AbRHENCP>;
	Sun, 5 Aug 2001 09:02:15 -0400
Date: Sun, 5 Aug 2001 16:02:04 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010805160204.J11046@mea-ext.zmailer.org>
In-Reply-To: <9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org> <3B6B4B21.B68F4F87@zip.com.au>, <3B6B4B21.B68F4F87@zip.com.au> <20010804131904.E18108@weta.f00f.org> <3B6B53A9.A9923E21@zip.com.au> <20010804060423.I16516@emma1.emma.line.org> <20010805063003.B20111@weta.f00f.org> <20010805141546.B13438@emma1.emma.line.org> <20010806003242.F21650@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010806003242.F21650@weta.f00f.org>; from cw@f00f.org on Mon, Aug 06, 2001 at 12:32:42AM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 12:32:42AM +1200, Chris Wedgwood wrote:
> On Sun, Aug 05, 2001 at 02:15:46PM +0200, Matthias Andree wrote:
> 
>     Why does it? Each file-system is self-contained with respect to hard
>     links. You cannot have link cross file system boundaries.
> 
>     Common code can be placed into a library. (Probably 2.5 stuff though.)
> 
> As pointed out by Jan Harkes, logic that works for ext2 (eg. walking
> the dentry chain and sync'ing all the components) sucks for things
> like Coda, where the performance impact may be noticable (actually,
> I'm not conviced it will be, but what do I know).
> 
> Not only that, it doesn't help qmail, cyrus imapd or Postfix
> completely.

	And for that matter, it (full access-tree fsync()ing) isn't
	necessary for systems which don't go around creating directories,
	instead place things into existing ones, and move things around
	in between the directories.


>   --cw

/Matti Aarnio
