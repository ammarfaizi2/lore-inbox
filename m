Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266320AbUBQQwz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266325AbUBQQwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:52:55 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:30890 "EHLO
	mailout.schmorp.de") by vger.kernel.org with ESMTP id S266320AbUBQQww
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:52:52 -0500
Date: Tue, 17 Feb 2004 17:52:48 +0100
From: Marc Lehmann <pcg@schmorp.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re: JFS default behavior)
Message-ID: <20040217165248.GF8231@schmorp.de>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040216183616.GA16491@schmorp.de> <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de> <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org> <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de> <Pine.LNX.4.58.0402170739580.2154@home.osdl.org> <20040217161111.GE8231@schmorp.de> <Pine.LNX.4.58.0402170820070.2154@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402170820070.2154@home.osdl.org>
X-Operating-System: Linux version 2.4.24 (root@cerebro) (gcc version 2.95.4 20011002 (Debian prerelease)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 17, 2004 at 08:32:15AM -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > Because there is a fundamental difference between file contents and
> > filenames. Filenames are supposed to be text.
> 
> I think this is actually the fundamental point where we disagree.

I guess that probably explains it. And I know of no striking arguments to
convince you of changing your fundamental opinion.

*sigh*. Ok, we agree to disagree :)

> It may be rare, but unlike you, I don't think there is anything "wrong" 
> with considering path components to be just "data".

Yeah, there are three things - text, binary, and data (and probably more).

Filenames are then "mostly text", "no binary", and still suitable for
"data".

I have read the example somebody posted of some application encoding
"near-binary" data into filenames (e.g. uglies like "\n" or worse).
However, I think that these cases are extremely rare and not really worth
supporting. Not supporting this is not a problem for applications - after
all, base64 or escaping (that is needed even for "near-binary") works fine
for these apps, too, ignoring the problem of backwards compatibility.

I think that everyone having had the experience of dealing with filenames
containing \n etc., despite your shell/GUI helping in quoting, will easily
share this opinion about usefulness.

That's why it should be a mount option, i.e. an enforcable standard.

And since it seems that JFS already supports this (to some degree unknown
to me), I don't think it should be such a pain to implement.

But yes, I am most probably not going to implement it, especially not if
it will simply never be accepted.

So I guess it simply won't be done. I think it's omissing some highly
useful feature, but I will survive it.

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
