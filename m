Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266989AbSKLVtt>; Tue, 12 Nov 2002 16:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266993AbSKLVtt>; Tue, 12 Nov 2002 16:49:49 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:27354 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266989AbSKLVtU>;
	Tue, 12 Nov 2002 16:49:20 -0500
Date: Tue, 12 Nov 2002 21:55:56 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Andi Kleen <ak@suse.de>
Cc: Adam Voigt <adam@cryptocomm.com>, linux-kernel@vger.kernel.org
Subject: Re: File Limit in Kernel?
Message-ID: <20021112215556.GA14819@bjl1.asuk.net>
References: <1037115535.1439.5.camel@beowulf.cryptocomm.com.suse.lists.linux.kernel> <p738yzywzrd.fsf@oldwotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p738yzywzrd.fsf@oldwotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > cp -f * /usr/local/www/images
> 
> Kind of. The * is expanded by the shell. The kernel limits the max
> length of program arguments, which is biting you here. In theory you
> could increase the MAX_ARG_PAGES #define in linux/binfmts.h and
> recompile. No guarantee that it won't have any bad side effects
> though. The default is rather low, it should be probably increased 
> (I also regularly run into this)

Yes, you can do this.  I used to do it with 2.0 kernels, because our
"make" command lines were very lock, and you couldn't use files to
hold the list of make-generated names because even "echo
$(LIST_OF_FILES) > list" hit this limit.

Ages ago somebody promised to fix this limitation :)

-- Jamie
