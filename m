Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbUKGNhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUKGNhZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 08:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbUKGNhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 08:37:25 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:23691 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S261586AbUKGNhN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 08:37:13 -0500
Date: Sun, 7 Nov 2004 14:37:11 +0100
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bloat
Message-ID: <20041107133711.GA3310@janus>
References: <Pine.LNX.4.58.0411041546160.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041353360.2187@ppc970.osdl.org> <Pine.LNX.4.58.0411041734100.1229@gradall.private.brainfood.com> <Pine.LNX.4.58.0411041544220.2187@ppc970.osdl.org> <20041105014146.GA7397@pclin040.win.tue.nl> <Pine.LNX.4.58.0411050739190.2187@ppc970.osdl.org> <20041106120716.GA9144@pclin040.win.tue.nl> <Pine.LNX.4.58.0411060922260.2223@ppc970.osdl.org> <20041106193605.GL1295@stusta.de> <20041106214147.GA9663@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041106214147.GA9663@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 10:41:47PM +0100, Andries Brouwer wrote:
> 
> I have one or two unused functions inside #if 0 in sddr09.c.
> Finding out the proper hardware details was nontrivial,
> it would be a pity to throw the knowledge away.

Of course nobody likes to throw away hard work. However, code that isn't
used tends to be unmaintained. So it might be outdated when (and if)
it gets used in the future. A web page indexed by search engines is a
excellent way to preserve knowledge.

The existence of unused code in the kernel will probably make not much
of a difference for future development. But it pollutes the source so
IMHO we could do without many of these:

$ find -name '*.[ch]' |xargs grep '^#if 0'|wc
   2491    7202   97634					(2.6.9-rc3)

-- 
Frank
