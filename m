Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315941AbSGVD5d>; Sun, 21 Jul 2002 23:57:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSGVD5d>; Sun, 21 Jul 2002 23:57:33 -0400
Received: from mail.gmx.de ([213.165.64.20]:40881 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315941AbSGVD5d>;
	Sun, 21 Jul 2002 23:57:33 -0400
Message-ID: <3D3B8334.6755F14@gmx.de>
Date: Mon, 22 Jul 2002 05:59:48 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
References: <Pine.LNX.4.44.0207210934180.3794-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> In contrast, if you could just rely on absolute time in select(), you
> would be re-startable _and_ you'd not have to do the extra "what time is
> it now, so that I know what timeout I need to use for the next thing"?

I agree.  Absolute times are nicer.  Just one note: to make that work
you need a sane time source!  gettimeofday jumps back and forth.  You
want a getuptime (or similar) that gives a constant monotonous growing
value not adjustable from userspace (and preferably the same for all
processes).

Ciao, ET.
