Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWI2CAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWI2CAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 22:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWI2CAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 22:00:09 -0400
Received: from cantor2.suse.de ([195.135.220.15]:52401 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751289AbWI2CAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 22:00:07 -0400
From: Neil Brown <neilb@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Date: Fri, 29 Sep 2006 11:59:46 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17692.32274.496872.473492@cse.unsw.edu.au>
Cc: "J. Bruce Fields" <bfields@fieldses.org>, Andrew Morton <akpm@osdl.org>,
       nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [NFS] [PATCH 009 of 11] knfsd: Allow max size of NFSd payload
 to be configured.
In-Reply-To: message from Hugh Dickins on Thursday September 28
References: <20060824162917.3600.patches@notabene>
	<1060824063716.5020@suse.de>
	<20060925212457.GK32762@fieldses.org>
	<17691.19982.162616.572205@cse.unsw.edu.au>
	<Pine.LNX.4.64.0609281752290.32574@blonde.wat.veritas.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday September 28, hugh@veritas.com wrote:
> > 
> > I'll submit a patch which uses
> >         12 - PAGE_SHIFT
> > in a little while.
> 
> I haven't seen your context; but "12 - PAGE_SHIFT" sounds like a
> bad idea on all those architectures with PAGE_SHIFT 13 or more;
> you'll be on much safer ground working with "PAGE_SHIFT - 12".

Ahhh yes... of course.  Thanks.

		totalram <<= PAGE_SHIFT - 12;

Is what I want to convert a number of pages to 1/4096 the number of
bytes.

Thanks :-)

NeilBrown
