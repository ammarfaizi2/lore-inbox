Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268196AbUHQMpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268196AbUHQMpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 08:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268200AbUHQMpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 08:45:30 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:14993 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S268196AbUHQMp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 08:45:28 -0400
Date: Tue, 17 Aug 2004 16:45:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, jdike@addtoit.com,
       kai@germaschewski.name, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] 2.6.8-rc4-mm1 - Fix UML build
Message-ID: <20040817144527.GA7286@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	William Lee Irwin III <wli@holomorphy.com>, jdike@addtoit.com,
	kai@germaschewski.name, sam@ravnborg.org,
	linux-kernel@vger.kernel.org
References: <200408120414.i7C4EtJd010481@ccure.user-mode-linux.org> <20040815150635.5ac4f5df.akpm@osdl.org> <200408170602.i7H62LNj019126@ccure.user-mode-linux.org> <20040817050642.GK11200@holomorphy.com> <20040816221017.018b0ef9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816221017.018b0ef9.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 10:10:17PM -0700, Andrew Morton wrote:
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >
> > On Tue, Aug 17, 2004 at 02:02:21AM -0400, Jeff Dike wrote:
> > > The undefined symbol checking is continuing to cause UML pain.  This time,
> > > it picked up a bunch of 'w' symbols as undefined.  They were present in the
> > > 2.6.8-rc4-mm1 vmlinux and caused no problems for the final link, so I added
> > > them as a second special case to mksysmap (and I just noticed that I forgot
> > > a comment there - I can submit a patch for that if there's demand for one).
> > 
> > Likewise for sparc64; the 'w' symbols are showing up as 'undefined'
> > there too. Probably because [^w] isn't behaving as expected.
> > 
> 
> Sigh.  That patch is causing a ton of grief.  But Russell's reasons for
> needing it on ARM were solid, and it is a bit weird for any architecture to
> have undefined symbols in vmlinux.  I guess we persist.
Please note that the functionality is moved to scripts/mksysmap,
so Russell's original ldchk needs to be backed out.

	Sam
