Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261500AbVDNNfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbVDNNfa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 09:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVDNNfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 09:35:30 -0400
Received: from nef2.ens.fr ([129.199.96.40]:58375 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S261500AbVDNNfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 09:35:23 -0400
Subject: Re: Call to atention about using hash functions as content
	indexers (SCM saga)
From: Eric Rannaud <eric.rannaud@ens.fr>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Pedro Larroy <piotr@larroy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050414083018.GA24892@hexapodia.org>
References: <20050414083018.GA24892@hexapodia.org>
Content-Type: text/plain
Date: Thu, 14 Apr 2005 08:35:07 -0500
Message-Id: <1113485708.5744.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Thu, 14 Apr 2005 15:35:11 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-14 at 01:30 -0700, Andy Isaacson wrote:
> In particular, your defense here is specious.  I agree that second
> preimage is an unmanagably large problem for SHA1 for the forseeable
> future (say, 8 years out), but collision results almost always result in
> partially-controlled attack text.  So I can choose my nefarious content,
> and encode the collision entropy in non-operative text (a C comment, for
> example).

Everything you said is fair enough, and I do agree with this argument in
the context of authentication: that is if you expect an attack (even if
a chunk of non-operative bytes won't go unnoticed for long in a the
kernel tree, but that's not the point).

But the original post of Pedro was, I think, about collisions occurring
'randomly' between two genuine modifications of a source file. In
particular, the paper that was linked to by Pedro is concerned with this
kind of unexpected collisions, i.e. about integrity in normal operation
and not about security (btw, this paper seems kind of bogus to me
because it never specifies the hash function in use).

I took the example of this attack against SHA-1 only to illustrate that
*even* if you try to find a collision, you just can't find one (at least
these days).
>From which I think it is fair to say that such a collision won't happen
between two different versions of the same file, during the normal
process of revision.

I mean, if in the normal revision process of the kernel, a SHA-1
collision was to be found, by chance, who gets to publish the paper at
the next Crypto conference?

However, if we consider the case of an attack, well, that's different.
And you're right.

    /er.
-- 
http://www.eleves.ens.fr/home/rannaud/

