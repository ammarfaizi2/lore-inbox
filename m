Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261445AbVDJIsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVDJIsb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 04:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbVDJIsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 04:48:30 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:47537 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261448AbVDJImp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 04:42:45 -0400
Date: Sun, 10 Apr 2005 01:39:25 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Paul Jackson <pj@engr.sgi.com>, ross@jose.lug.udel.edu, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
In-Reply-To: <Pine.LNX.4.58.0504090916550.1267@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.62.0504100136290.14436@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org><20050408041341.GA8720@taniwha.stupidest.org>
 <Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org><20050408071720.GA23128@jose.lug.udel.edu>
 <Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org><20050409085017.7edf2c9a.pj@engr.sgi.com>
 <Pine.LNX.4.58.0504090916550.1267@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Apr 2005, Linus Torvalds wrote:

>
> The biggest irritation I have with the "tree" format I chose is actually
> not the name (which is trivial), it's the <sha1> part. Almost everything
> else keeps the <sha1> in the ASCII hexadecimal representation, and I
> should have done that here too. Why? Not because it's a <sha1> - hey, the
> binary representation is certainly denser and equivalent - but because an
> ASCII representation there would have allowed me to much more easily
> change the key format if I ever wanted to. Now it's very SHA1-specific.
>
> Which I guess is fine - I don't really see any reason to change, and if I
> do change, I could always just re-generate the whole tree. But I think it
> would have been cleaner to have _that_ part in ASCII.
>

just wanted to point out that recent news shows that sha1 isn't as good as 
it was thought to be (far easier to deliberatly create collisions then it 
should be)

this hasn't reached a point where you HAVE to quit useing it (especially 
since you have the other validity checks in place), but it's a good reason 
to expect that you may want to change to something else in a few years.

it's a lot easier to change things now to make that move easier then once 
this is being used extensively

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
