Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbUEJSvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbUEJSvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 14:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUEJSvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 14:51:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2992 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261236AbUEJSvJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 14:51:09 -0400
Date: Mon, 10 May 2004 19:51:07 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Paul Eggert <eggert@CS.UCLA.EDU>
Cc: Jon Oberheide <jon@focalhost.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, bug-patch@gnu.org, bug-gnu-utils@gnu.org
Subject: Re: [PATCH] [RFC] adding support for .patches and /proc/patches.gz
Message-ID: <20040510185107.GD17014@parcelfarce.linux.theplanet.co.uk>
References: <1084157289.7867.0.camel@latitude> <87oeowb029.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87oeowb029.fsf@penguin.cs.ucla.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 11:37:34AM -0700, Paul Eggert wrote:
> Jon Oberheide <jon@focalhost.com> writes:
> 
> > I'm CC'ing this to the GNU patch maintainers.  Hopefully they will have
> > some input.
> 
> As I understand it, Solution 4 is an incompatible change to 'patch'
> which would cause 'patch' to not conform to POSIX, the LSB, or to
> widespread existing practice.  That's a pretty serious step, and I'm
> not sure it's worth the aggravation.
> 
> Solution 3 would be to add an option to 'patch' to cause it to log the
> patches into a file.  The basic idea seems like a worthwhile
> improvement to 'patch', though (as you mention) it's more of a hassle
> for users to remember the option.
> 
> Perhaps there's a better way to address the problem in a way that
> maintains compatibility while still satisfying your needs.  For example,
> if the kernel patches all contained a line like this at the start:
> 
> Patch-log: .patches
> 
> then 'patch' could log all the changes into the named file.  This
> would conform to POSIX.

Not needed.

diff -erN dir1/file dir2/file
--- dir1/file
+++ dir2/file
1i
lines
.

will do just fine.  Remember that patch(1) can handle at least some ed
scripts.
