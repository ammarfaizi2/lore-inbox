Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131548AbQKTKJ2>; Mon, 20 Nov 2000 05:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbQKTKJS>; Mon, 20 Nov 2000 05:09:18 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:35099 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S131548AbQKTKJL>;
	Mon, 20 Nov 2000 05:09:11 -0500
Message-ID: <20001120103906.A565@win.tue.nl>
Date: Mon, 20 Nov 2000 10:39:06 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Eric Paire <paire@ri.silicomp.fr>, Alexander Viro <viro@math.psu.edu>
Cc: Jean-Marc Saffroy <saffroy@ri.silicomp.fr>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Inconsistent behaviour of rmdir
In-Reply-To: <Pine.GSO.4.21.0011171514210.18150-100000@weyl.math.psu.edu> <200011200832.JAA19770@mailhost.ri.silicomp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200011200832.JAA19770@mailhost.ri.silicomp.fr>; from Eric Paire on Mon, Nov 20, 2000 at 09:32:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2000 at 09:32:39AM +0100, Eric Paire wrote:
> > 
> > On Fri, 17 Nov 2000, Guest section DW wrote:
> > 
> > > I see that an entire discussion has taken place. Let me just remark this,
> > > quoting the Austin draft:
> > > 
> > > If the path argument refers to a path whose final component is either
> > > dot or dot-dot, rmdir( ) shall fail.
> > > 
> > > EINVAL	The path argument contains a last component that is dot.
> > [snip]
> > 
> Then, I don't understand why the EINVAL error condition does not also include
> dot-dot as last component.

Answer 1: It is the (draft) standard. No understanding required.

Answer 2: Whenever ENOTEMPTY is available, this much more precise error return
is to be preferred above EINVAL.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
