Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVDZPUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVDZPUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 11:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVDZPUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 11:20:22 -0400
Received: from pat.uio.no ([129.240.130.16]:45793 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261577AbVDZPUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 11:20:07 -0400
Subject: Re: filesystem transactions API
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: John Stoffel <john@stoffel.org>
Cc: Jamie Lokier <jamie@shareable.org>,
       "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>, Ville Herva <v@iki.fi>,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <17006.22498.394169.98413@smtp.charter.net>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
	 <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com>
	 <20050426134629.GU16169@viasys.com>
	 <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru>
	 <20050426143247.GF10833@mail.shareable.org>
	 <17006.22498.394169.98413@smtp.charter.net>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 11:19:42 -0400
Message-Id: <1114528782.13568.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.722, required 12,
	autolearn=disabled, AWL 1.28, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 26.04.2005 Klokka 11:01 (-0400) skreiv John Stoffel:
> >>>>> "Jamie" == Jamie Lokier <jamie@shareable.org> writes:
> 
> Jamie> No.  A transaction means that _all_ processes will see the
> Jamie> whole transaction or not.
> 
> This is really hard.  How do you handle the case where process X
> starts a transaction modifies files a, b & c, but process Y has file b
> open for writing, and never lets it go?  Or the file gets unlinked?  

That is why implementing it as a form of lock makes sense.

> Jamie> For example, you can use transactions for distro package
> Jamie> management: a whole update of a package would be a single
> Jamie> transaction, so that at no time does any program see an
> Jamie> inconsistent set of files.  See why _every_ process in the
> Jamie> system must have the same view?
> 
> What about programs that are already open and running?  
> 
> It might be doable in some sense, but I can see that details are
> really hard to get right.  Esp without breaking existing Unix
> semantics.  

Wrong.

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

