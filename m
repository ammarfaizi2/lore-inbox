Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319391AbSIFUxl>; Fri, 6 Sep 2002 16:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319389AbSIFUxh>; Fri, 6 Sep 2002 16:53:37 -0400
Received: from [195.39.17.254] ([195.39.17.254]:3712 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S319391AbSIFUwK>;
	Fri, 6 Sep 2002 16:52:10 -0400
Date: Fri, 6 Sep 2002 12:53:26 +0000
From: Pavel Machek <pavel@suse.cz>
To: junkio@cox.net
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [TRIVIAL] strlen("literal string") -> (sizeof("literal string")-1)
Message-ID: <20020906125326.G39@toy.ucw.cz>
References: <fa.iks3ohv.1flge08@ifi.uio.no> <200208282131.g7SLVVGx024191@siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200208282131.g7SLVVGx024191@siamese.dyndns.org>; from junkio@cox.net on Wed, Aug 28, 2002 at 02:31:31PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

> Here is a patch that does the same as what Keith Owens did in
> his patch recently.
> 
>     Message-ID: <fa.iks3ohv.1flge08@ifi.uio.no>
>     From: Keith Owens <kaos@ocs.com.au>
>     Subject: [patch] 2.4.19 Generate better code for nfs_sillyrename
>     Date: Wed, 28 Aug 2002 07:08:17 GMT
> 
>     Using strlen() generates an unnecessary inline function expansion plus
>     dynamic stack adjustment.  For constant strings, strlen() == sizeof()-1
>     and the object code is better.

Gcc should be able to do this itself.

> The patch is against 2.4.19.
> 

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

