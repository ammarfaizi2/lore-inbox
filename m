Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267610AbSLNNgV>; Sat, 14 Dec 2002 08:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267611AbSLNNgV>; Sat, 14 Dec 2002 08:36:21 -0500
Received: from [81.2.122.30] ([81.2.122.30]:64004 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S267610AbSLNNgU>;
	Sat, 14 Dec 2002 08:36:20 -0500
From: John Bradford <john@bradfords.org.uk>
Message-Id: <200212141355.gBEDtb7q000952@darkstar.example.net>
Subject: Re: Symlink indirection
To: andrew@walrond.org (Andrew Walrond)
Date: Sat, 14 Dec 2002 13:55:37 +0000 (GMT)
Cc: jhf@rivenstone.net, linux-kernel@vger.kernel.org
In-Reply-To: <3DFB2859.80401@walrond.org> from "Andrew Walrond" at Dec 14, 2002 12:47:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     I don't understand what you are trying to explain.  Do you mean a
> > union mount, or a variation thereof?
> > 
> >     I thought Al Viro was going to do union mount support for 2.5, but
> > I haven't heard about it in a while.  Maybe it went in and no one noticed?

> I'm not familiar with the phrase 'union mount' and although google gives 
> wads of hits, I can't find a good description of it
> 
> What I mean is (contrived example with made-up mount option --overlay)

> mkdir a
> echo "a/x" > a/x
> echo "a/y" > a/y
> echo "a/z" > a/z
> 
> mkdir b
> echo "b/y" > b/y
> 
> mkdir c
> echo "c/z" > c/z
> 
> mkdir d
> mount --bind a d
> mount --bind --overlay b d
> mount --bind --overlay c d
> 
> cat d/x
> "a/x"
> 
> cat d/y
> "b/x"

Shouldn't that be "b/y"?

> cat d/z
> "c/z"

John.
