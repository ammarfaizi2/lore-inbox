Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269949AbRHEMcO>; Sun, 5 Aug 2001 08:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269950AbRHEMcE>; Sun, 5 Aug 2001 08:32:04 -0400
Received: from weta.f00f.org ([203.167.249.89]:40080 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S269949AbRHEMbt>;
	Sun, 5 Aug 2001 08:31:49 -0400
Date: Mon, 6 Aug 2001 00:32:42 +1200
From: Chris Wedgwood <cw@f00f.org>
To: linux-kernel@vger.kernel.org
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010806003242.F21650@weta.f00f.org>
In-Reply-To: <9keqr6$egl$1@penguin.transmeta.com>, <9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org> <3B6B4B21.B68F4F87@zip.com.au>, <3B6B4B21.B68F4F87@zip.com.au> <20010804131904.E18108@weta.f00f.org> <3B6B53A9.A9923E21@zip.com.au> <20010804060423.I16516@emma1.emma.line.org> <20010805063003.B20111@weta.f00f.org> <20010805141546.B13438@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010805141546.B13438@emma1.emma.line.org>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, Aug 05, 2001 at 02:15:46PM +0200, Matthias Andree wrote:

    Why does it? Each file-system is self-contained with respect to hard
    links. You cannot have link cross file system boundaries.

    Common code can be placed into a library. (Probably 2.5 stuff though.)

As pointed out by Jan Harkes, logic that works for ext2 (eg. walking
the dentry chain and sync'ing all the components) sucks for things
like Coda, where the performance impact may be noticable (actually,
I'm not conviced it will be, but what do I know).

Not only that, it doesn't help qmail, cyrus imapd or Postfix
completely.




  --cw
