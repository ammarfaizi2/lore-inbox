Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269655AbUJABMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269655AbUJABMl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 21:12:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269656AbUJABMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 21:12:41 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:12427 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S269655AbUJABMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 21:12:40 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Date: Fri, 1 Oct 2004 11:12:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16732.44796.86341.578389@cse.unsw.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] exportfs: reduce stack usage
In-Reply-To: message from Randy.Dunlap on Tuesday September 28
References: <20040928215718.55ed72a5.rddunlap@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday September 28, rddunlap@osdl.org wrote:
> 
> find_exported_dentry() declares
> 	char nbuf[NAME_MAX+1];
> in 2 separate places, and gcc allocates space on the stack for both
> of them.  Having just one of them will suffice, if we can put put
> with its scope.
> 
> Reduces function stack usage on x86-32 from 0x230 to 0x130.

So it does.  I thought gcc was cleverer than that.
I'll add it to my collection.

Thanks,
NeilBrown
