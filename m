Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275354AbTHMTnF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 15:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275358AbTHMTm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 15:42:58 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:24448 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S275354AbTHMTmb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 15:42:31 -0400
Date: Wed, 13 Aug 2003 20:42:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Andrew Morton OSDL <akpm@osdl.org>, willy@w.ods.org, chip@pobox.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
Message-ID: <20030813194201.GG4405@mail.jlokier.co.uk>
References: <1060488233.780.65.camel@cube> <20030810072945.GA14038@alpha.home.local> <20030811012337.GI24349@perlsupport.com> <20030811020957.GE10446@mail.jlokier.co.uk> <20030811023912.GJ24349@perlsupport.com> <20030811053059.GB28640@alpha.home.local> <20030811054209.GN10446@mail.jlokier.co.uk> <1060607398.948.213.camel@cube> <20030811115547.38b78b8e.akpm@osdl.org> <1060643637.949.228.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060643637.949.228.camel@cube>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> > Being a simple soul, I prefer __builtin_expect((x) != 0, 1).
> 
> That's much harder to read. The !! is a nice
> neat idiom. The other way requires a bit of thought.
> (is that == or !=, a 0 or 1, and what does that
> compute to?)
> 
> The !! is visually distinctive. It has only one use.
> When you see it, you instantly know that a value is
> being converted to the pure boolean form.

Dear Albert,

I have to tell you your are totally wrong :)

Most C programmers will find "!!x" less clear than "x != 0", simply
because "!!x" isn't used all that much.

If you require significant thought to parse "x != 0" you are going to
have trouble with more complex idioms.

Like "x && 1" and "x || 0", which are obvious to anyone :)

-- Jamie
