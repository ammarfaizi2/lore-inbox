Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUIMCGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUIMCGj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 22:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUIMCGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 22:06:39 -0400
Received: from [12.177.129.25] ([12.177.129.25]:49603 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S264937AbUIMCGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 22:06:35 -0400
Date: Sun, 12 Sep 2004 23:10:14 -0400
From: Jeff Dike <jdike@addtoit.com>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net,
       David Jeffery <djeffery@britsys.net>, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH] nptl/sys_clone fix for i386/ppc
Message-ID: <20040913031014.GA13184@ccure.user-mode-linux.org>
References: <20040826020626.GA28471@malice.crymeariver.org> <200409111745.18659.blaisorblade_spam@yahoo.it> <20040911182615.GB2966@ccure.user-mode-linux.org> <200409121752.07398.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409121752.07398.blaisorblade_spam@yahoo.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 05:52:44PM +0200, BlaisorBlade wrote:
> It worked no worse than current version (which is broken). In fact the 2.4 
> clone had 2 arguments. So it's obvious.

In fact, it worked better.  It worked on a modern Debian filesystem, where
my old code didn't.  Hence I didn't notice the mistake (although I should 
have compared what I did with David's patch and justified the differences,
if any).

> However, this is non-standard. I've added just a comment for now, since you 
> may have reason to keep the current code, but such behaviour calls for 
> breakage when things change.

Yeah, I not sure why I did things the way I did.  That's very old code, and
there may have been some good reason for it which has since disappeared.

Offhand, it looks like doing things in the standard way will clean up
copy_thread a bit.

				Jeff
