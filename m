Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267668AbTBLVg5>; Wed, 12 Feb 2003 16:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267692AbTBLVg5>; Wed, 12 Feb 2003 16:36:57 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8974 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267668AbTBLVg4>; Wed, 12 Feb 2003 16:36:56 -0500
Date: Wed, 12 Feb 2003 13:42:58 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: <200302122111.h1CLB9D24412@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302121341270.1096-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Feb 2003, Roland McGrath wrote:
> 
> This should be fine (almost).  POSIX leaves it unspecified whether a
> blocked, ignored signal is left pending or not.  The only thing it requires
> is that setting a blocked signal to SIG_IGN clears any pending signal, and
> sigaction already does that.

Hmm.. We could move the blocking test down, and only consider that for the 
"SIG_DFL" case. 

The function I did matches what the old signal code did, but the more 
signals we can truly ignore, the better. I dunno.

		Linus

