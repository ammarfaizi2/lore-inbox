Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266751AbUGLHkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266751AbUGLHkv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 03:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266752AbUGLHkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 03:40:51 -0400
Received: from havoc.gtf.org ([216.162.42.101]:42949 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S266751AbUGLHku (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 03:40:50 -0400
Date: Mon, 12 Jul 2004 03:40:48 -0400
From: David Eger <eger@havoc.gtf.org>
To: Andrew Morton <akpm@osdl.org>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] radeonfb: cleanup and little fixes
Message-ID: <20040712074048.GA19875@havoc.gtf.org>
References: <20040712062236.GA17610@havoc.gtf.org> <20040711233002.1ec2100f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040711233002.1ec2100f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2004 at 11:30:02PM -0700, Andrew Morton wrote:
> >  	if (rinfo->mon1_EDID)
> >  	    kfree(rinfo->mon1_EDID);
> >  	if (rinfo->mon2_EDID)
> >  	    kfree(rinfo->mon2_EDID);
> 
> kfree(NULL) is legal, and this is a slow-path.  Those tests can be taken
> out next time, unless such a thing offends you.

I guess I wasn't zealous enough in my cleanup ;-)
(changing it doesn't bother me, I just hadn't noticed it)

I really appreciate the work you put in looking through all of the
patches you get.  Code review is a huge job, something I don't think
James really has time for, but somehow you find it :)

-dte
