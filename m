Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbTESKDM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbTESKDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:03:12 -0400
Received: from gate.perex.cz ([194.212.165.105]:13578 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S262140AbTESKDL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:03:11 -0400
Date: Mon, 19 May 2003 12:15:19 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove 2.2 compat cruft from sound/
In-Reply-To: <20030519114217.A4325@lst.de>
Message-ID: <Pine.LNX.4.44.0305191208340.21997-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 May 2003, Christoph Hellwig wrote:

> On Mon, May 19, 2003 at 11:38:56AM +0200, Christoph Hellwig wrote:
> > On Mon, May 19, 2003 at 10:44:46AM +0200, Jaroslav Kysela wrote:
> > > We still support the 2.2 kernel. We are trying to separate this 
> > > "compatibility" code to another location, but in some cases, it is 
> > > difficult. Please, make changes only for /sound/oss tree. Thank you.
> > 
> > I sterongly disagree.  As part of having your code in mainline you
> > have to keep it readable.  Neither the compat mess nor the typedef
> > abuse help on this.
> > 
> 
> And it's not like the 2.2 code was actually working, e.g. the dropping
> of i_sem in ->write makes you allow multiple simultanous writes, your
> module refcounting on 2.2 is completly b0rked due to the lack of ->owner
> and many functions have change parameters..

Note we already removed 99% of compatibility code, but the remaining 
pieces are very difficult to solve with C preprocesor. I know that you 
do not care about older kernels, but we have good reasons to share code.
It very simplifies maintaince.

Please, let us to remove this compatibility stuff. I will probably use 
one more level of preprocessing to keep the compatibility in our build 
tree.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs

