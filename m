Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264793AbTFYRPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264670AbTFYRNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:13:50 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:27548 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264756AbTFYRNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:13:16 -0400
Date: Wed, 25 Jun 2003 19:27:03 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Christoph Hellwig <hch@infradead.org>, mocm@mocm.de,
       Michael Hunold <hunold@convergence.de>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: DVB Include files
Message-ID: <20030625172703.GC1770@wohnheim.fh-wedel.de>
References: <20030625150629.GA1045@mars.ravnborg.org> <20030625160830.A19958@infradead.org> <20030625154223.GB1333@mars.ravnborg.org> <3EF9CB25.4050105@convergence.de> <16121.53934.527440.109966@sheridan.metzler> <20030625175513.A28776@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030625175513.A28776@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 June 2003 17:55:13 +0100, Christoph Hellwig wrote:
> On Wed, Jun 25, 2003 at 06:49:50PM +0200, Marcus Metzler wrote:
> > You mean include/linux/dvb, I hope. Otherwise, it will break all user space
> > applications.
> 
> No.  At least I hope he didn't mean it :)  Userspace has no _goddamn_
> business to look at kernel headers.  Just stick a copy of those into
> /usr/include/dvb/ for your applications that's in the dvb-dev or whatever
> package.

Christoph, while I agree with you, I also see why a lot of people just
symlink /usr/include/linux to /usr/src/.../include/linux.  Pure
convenience and the lack of a dedicated collection of userspace
headers outside a distributions scope.

Seperating userspace headers from kernel headers would also be a good
thing, as the #ifdef __KERNEL__ #else #endif orgy could finally be
reduced a bit.

Since these headers do depend on the kernel version and should be the
official interface between kernel and userspace, maintaining them
inside the kernel tree would also, imho, be a Good Thing.

So imnsho the "don't use the kernel headers" comment I read on a
common basis is not a very helpful advice, as long as we are missing
in this respect.

Or did I miss something important and just exposed my stupidity?

Jörn

-- 
Public Domain  - Free as in Beer
General Public - Free as in Speech
BSD License    - Free as in Enterprise
Shared Source  - Free as in "Work will make you..."
