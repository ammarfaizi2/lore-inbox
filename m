Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVDNAQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVDNAQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 20:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVDNAPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 20:15:22 -0400
Received: from waste.org ([216.27.176.166]:31136 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261236AbVDNANZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 20:13:25 -0400
Date: Wed, 13 Apr 2005 17:13:06 -0700
From: Matt Mackall <mpm@selenic.com>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       David Eger <eger@havoc.gtf.org>, Petr Baudis <pasky@ucw.cz>,
       "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: more git updates..
Message-ID: <20050414001306.GI3174@waste.org>
References: <20050412040519.GA17917@havoc.gtf.org> <20050412081613.GA18545@pasky.ji.cz> <20050412204429.GA24910@havoc.gtf.org> <Pine.LNX.4.58.0504121411030.4501@ppc970.osdl.org> <20050412234005.GJ1521@opteron.random> <Pine.LNX.4.58.0504121644430.4501@ppc970.osdl.org> <20050413001408.GL1521@opteron.random> <Pine.LNX.4.58.0504121809380.4501@ppc970.osdl.org> <20050413204451.GP25554@waste.org> <m3vf6q1bxo.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3vf6q1bxo.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 01:42:11AM +0200, Krzysztof Halasa wrote:
> Matt Mackall <mpm@selenic.com> writes:
> 
> > Now if you can assume that blobs never change and are never deleted,
> > you can simply append them all onto a log, and then index them with a
> > separate file containing an htree of (sha1, offset, length) or the
> > like.
> 
> That mean a problem with rsync, though.

I believe 200k inodes is a problem for rsync too. But we can simply
grab the remote htree, do a tree compare, find the ranges of the
remote file we need, sort and merge the ranges, and then pull them.
That will surely trounce rsync.

-- 
Mathematics is the supreme nostalgia of our time.
