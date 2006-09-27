Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932372AbWI0MlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbWI0MlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 08:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWI0MlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 08:41:08 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:24062 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932372AbWI0MlH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 08:41:07 -0400
Date: Wed, 27 Sep 2006 14:39:59 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] x86: Add portable getcpu call
Message-ID: <20060927123959.GC6872@osiris.boeblingen.de.ibm.com>
References: <200609262300.k8QN06dD013707@hera.kernel.org> <20060927113739.GB6872@osiris.boeblingen.de.ibm.com> <200609271404.09621.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609271404.09621.ak@suse.de>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > So this means that the contents of getcpu_cache will look completely
> > different if a process runs in 32bit mode or 64bit mode. Even if you're
> > saying "user programs should not..." this looks odd to me.
> > Is this really on purpose and do you really think that no user space
> > application will ever rely on the format of getcpu_cache?
> 
> The vsyscalls do, but if anything else does it deserves breaking.
> In the user headers it will also be just a array blob.

Ah, ok. The blob thing is the part I missed then.

> I was considering to xor it with a random value to bring the point across
> more strongly, but then didn't do it. Do you think I should? 

No, I don't think that will help much.
