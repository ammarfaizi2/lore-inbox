Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274896AbTHKXYa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 19:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274888AbTHKXYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 19:24:30 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:1018 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S274896AbTHKXY2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 19:24:28 -0400
Subject: Re: [PATCH] 2.4.22pre10: {,un}likely_p() macros for pointers
From: Albert Cahalan <albert@users.sf.net>
To: Andrew Morton OSDL <akpm@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>, willy@w.ods.org,
       chip@pobox.com,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davem@redhat.com
In-Reply-To: <20030811115547.38b78b8e.akpm@osdl.org>
References: <1060488233.780.65.camel@cube>
	 <20030810072945.GA14038@alpha.home.local>
	 <20030811012337.GI24349@perlsupport.com>
	 <20030811020957.GE10446@mail.jlokier.co.uk>
	 <20030811023912.GJ24349@perlsupport.com>
	 <20030811053059.GB28640@alpha.home.local>
	 <20030811054209.GN10446@mail.jlokier.co.uk> <1060607398.948.213.camel@cube>
	 <20030811115547.38b78b8e.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1060643637.949.228.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Aug 2003 19:13:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-11 at 14:55, Andrew Morton wrote:
> Albert Cahalan <albert@users.sourceforge.net> wrote:
> >
> > -#define likely(x)	__builtin_expect((x),1)
> > -#define unlikely(x)	__builtin_expect((x),0)
> > +#define likely(x)	__builtin_expect(!!(x),1)
> > +#define unlikely(x)	__builtin_expect(!!(x),0)
> 
> Odd.  I thought we fixed that ages ago.
> 
> Being a simple soul, I prefer __builtin_expect((x) != 0, 1).

That's much harder to read. The !! is a nice
neat idiom. The other way requires a bit of thought.
(is that == or !=, a 0 or 1, and what does that
compute to?)

The !! is visually distinctive. It has only one use.
When you see it, you instantly know that a value is
being converted to the pure boolean form.



