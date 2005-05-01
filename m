Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVEAJMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVEAJMs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 05:12:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVEAJMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 05:12:48 -0400
Received: from colino.net ([213.41.131.56]:16626 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261567AbVEAJMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 05:12:46 -0400
Date: Sun, 1 May 2005 11:12:33 +0200
From: Colin Leroy <colin@colino.net>
To: Chris Wedgwood <cw@f00f.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] hfsplus: don't oops on bad FS
Message-ID: <20050501111233.5c638ff7@jack.colino.net>
In-Reply-To: <20050501050833.GA3045@taniwha.stupidest.org>
References: <20050425211915.126ddab5@jack.colino.net>
	<Pine.LNX.4.61.0504252145220.25129@scrub.home>
	<20050425220345.6b2ed6d5@jack.colino.net>
	<20050501050833.GA3045@taniwha.stupidest.org>
X-Mailer: Sylpheed-Claws 1.9.6cvs36 (GTK+ 2.6.4; powerpc-unknown-linux-gnu)
X-Face: Fy:*XpRna1/tz}cJ@O'0^:qYs:8b[Rg`*8,+o^[fI?<%5LeB,Xz8ZJK[r7V0hBs8G)*&C+XA0qHoR=LoTohe@7X5K$A-@cN6n~~J/]+{[)E4h'lK$13WQf$.R+Pi;E09tk&{t|;~dakRD%CLHrk6m!?gA,5|Sb=fJ=>[9#n1Bu8?VngkVM4{'^'V_qgdA.8yn3)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Apr 2005 at 22h04, Chris Wedgwood wrote:

Hi, 

> > +cleanup_little:
> >  	if (nls)
> >  		unload_nls(nls);
> > +	sb->s_fs_info = NULL;
> > +	kfree(sbi);
> 
> cleanup_little?  why not cleanup_no_put or something?

I was lacking this kind of inspiration :)
Roman's patch that Andrew just pushed superceded this one, anyway.

-- 
Colin
