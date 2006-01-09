Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWAIVqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWAIVqD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWAIVqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:46:03 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:3082 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750775AbWAIVqC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:46:02 -0500
Date: Mon, 9 Jan 2006 22:45:44 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Eric Sandeen <sandeen@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
Message-ID: <20060109214544.GA17315@mars.ravnborg.org>
References: <20060109164214.GA10367@mars.ravnborg.org> <20060109164611.GA1382@infradead.org> <43C2CFBD.8040901@sgi.com> <20060109212005.GC14477@mars.ravnborg.org> <43C2D45B.2050704@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C2D45B.2050704@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 03:23:39PM -0600, Eric Sandeen wrote:
> codebases.
> 
> But it seems useful for projects outside the kernel which would like to 
> know which kernel they are building against, as far as the build system 
> goes.  I've seen a few drivers out there that try to keep building for both 
> 2.4 & 2.6.
> 
> I guess for 2.4 & 2.6, the same can be accomplished by using Makefile and 
> Kbuild for 2.4 and 2.6....

Good point. External modules slipped my mind when I did this change.
We have today:
VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 15
EXTRAVERSION =

EXTRAVERSION will soon become -rc1
No sane driver will check for more than VERISON, PATCHLEVEL, SUBLEVEL.
xfs for once only used VERSION, PATCHLEVEL.

googling a little gave lot's of very ugly examples how it can be done
using grep, perl etc. So there is a legitim need for the variable
anyway.
So I will re-export VERISON, PATCHLEVEL, SUBLEVEL.

	Sam
