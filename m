Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275221AbTHAOji (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 10:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275218AbTHAOjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 10:39:37 -0400
Received: from tandu.perlsupport.com ([66.220.6.226]:47540 "EHLO
	tandu.perlsupport.com") by vger.kernel.org with ESMTP
	id S275221AbTHAOjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 10:39:10 -0400
Date: Fri, 1 Aug 2003 10:38:07 -0400
From: Chip Salzenberg <chip@pobox.com>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Steve Dickson <SteveD@redhat.com>, nfs@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: nfs-utils-1.0.5 is not backwards compatible with 2.4
Message-ID: <20030801143807.GB24358@perlsupport.com>
References: <3F294DE3.9020304@RedHat.com> <16169.54918.472349.928145@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16169.54918.472349.928145@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Neil Brown:
> I don't know if there is any such code, but if there is I apoligize for
> breaking it and suggest that the best fix is to not use the header
> file it was using but it explicitly include the values for NFSEXP_* in
> that code.

The only really bad thing about the current situation is that the name
"NFSEXP_CROSSMNT" is poisoned by having had two historical
definitions.  So it that name should be dropped, IMO, and replaced by
something textually different.  "NFSEXP_XMOUNT", perhaps.  Even
"NFSEXP_CROSSMNT2" would work.  Just as long as code that said
"CROSSMNT" to mean "NOHIDE" wouldn't accidentally get CROSSMNT instead.
-- 
Chip Salzenberg               - a.k.a. -               <chip@pobox.com>
"I wanted to play hopscotch with the impenetrable mystery of existence,
    but he stepped in a wormhole and had to go in early."  // MST3K
