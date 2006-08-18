Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751341AbWHRKOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWHRKOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 06:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWHRKOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 06:14:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58123 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751342AbWHRKOM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 06:14:12 -0400
Date: Fri, 18 Aug 2006 08:39:12 +0000
From: Pavel Machek <pavel@suse.cz>
To: David Howells <dhowells@redhat.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org#
Subject: Re: [RHEL5 PATCH 1/4] Provide fallback full 64-bit divide/modulus ops for gcc
Message-ID: <20060818083911.GB7516@ucw.cz>
References: <p734pwea07b.fsf@verdi.suse.de> <20060814211504.27190.10491.stgit@warthog.cambridge.redhat.com> <20060814211507.27190.61876.stgit@warthog.cambridge.redhat.com> <7510.1155630597@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7510.1155630597@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-08-06 09:29:57, David Howells wrote:
> Andi Kleen <ak@suse.de> wrote:
> 
> > At least Linus' traditional argument against this is that it's better
> > to open code these (do_div) so that it's clear to the coder that they
> > are really costly.
> 
> do_div() is not a full replacement for __udivdi3(), __umoddi3() or
> __udivmoddi4(), though I suspect we don't need divisor >= 2^32 anywhere atm.
> 
> There are places where the compiler emits these that aren't entirely obvious,
> one of which IIRC is in ext2 inode allocation.

Well -- but that is good reason to keep that open-coded, right?

-- 
Thanks for all the (sleeping) penguins.
