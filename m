Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbWCTVql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbWCTVql (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWCTVql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:46:41 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:29865 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964990AbWCTVqk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:46:40 -0500
Date: Tue, 21 Mar 2006 08:46:19 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Parenthesize macros in xfs
Message-ID: <20060321084619.E653275@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.61.0603202207310.20060@yvahk01.tjqt.qr> <20060321082327.B653275@wobbly.melbourne.sgi.com> <Pine.LNX.4.61.0603202239110.11933@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0603202239110.11933@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Mon, Mar 20, 2006 at 10:39:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Mon, Mar 20, 2006 at 10:39:45PM +0100, Jan Engelhardt wrote:
> >> while browsing through the xfs/linux source, I noticed that many macros do 
> >> not do proper bracing. I have started to cook up a patch, but would like 
> >> feedback first before I continue for nothing.
> >> It goes like this:
> >> ...
> >
> >That looks fine.  Please be sure to work on the -mm tree or on
> >CVS on oss.sgi.com, so as to reduce your level of patch conflict.
> >
> 
> Hm, would not it even be better to make them 'static inline' functions?

Probably, I guess I'd want to see how invasive the patch becomes...?
I really dislike those _ACL macros (around that example you gave, that
could do with a cleanup all of its own - switching to xfs_acl_ maybe).
Also watch for macros that modify their parameters, I got burned by
doing an inline conversion a few releases back on just such a beast..

cheers.

-- 
Nathan
