Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264293AbUD0TKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264293AbUD0TKr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264300AbUD0TKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:10:47 -0400
Received: from ns.suse.de ([195.135.220.2]:57037 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264293AbUD0TKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:10:45 -0400
Subject: Re: [PATCH] Return more useful error number when acls are too large
From: Andreas Gruenbacher <agruen@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040427183228.GF2086@fieldses.org>
References: <1082973939.3295.16.camel@winden.suse.de>
	 <20040427183228.GF2086@fieldses.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1083093044.16824.312.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 27 Apr 2004 21:10:45 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 20:32, J. Bruce Fields wrote:
> On Mon, Apr 26, 2004 at 12:27:58PM +0200, Andreas Gruenbacher wrote:
> > could you please add this to mainline? Getting EINVAL when an acl
> > becomes too large is quite confusing.
> 
> On my system, at least, "man acl_set_file" does explicitly say that
> EINVAL is returned in this case.  Whether that should be considered a
> bug in the documentation or the code I don't know....

Indeed ... looking at POSIX 1003.1e draft 17 I now see that this
function is indeed supposed to return EINVAL in this case. I was
assuming that this case was undefined, but that was wrong. So let's
leave the code as is -- sorry.


Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

