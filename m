Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbUKSEiB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbUKSEiB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 23:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261252AbUKSEiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 23:38:01 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:9399 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261250AbUKSEh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 23:37:58 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: martin f krafft <madduck@madduck.net>
Date: Fri, 19 Nov 2004 15:42:55 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16797.31183.853387.514386@cse.unsw.edu.au>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 nfsd crashing often
In-Reply-To: message from martin f krafft on Thursday November 18
References: <20041118173504.GA24187@cirrus.madduck.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 18, madduck@madduck.net wrote:
> We upgraded our cluster master server to 2.6.9 this morning and are
> now experiencing major problems with the kernel NFS server, which
> crashes every hours or so:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 00000000
>   printing eip:
>   00000000
...
>   Call Trace:
>   [<c0166197>] __lookup_hash+0xa7/0xe0

Looks like i_op->lookup == NULL, and I don't think nfsd could do that.

What filesystem are you using?

NeilBrown

