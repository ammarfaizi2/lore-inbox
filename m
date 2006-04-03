Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWDCBTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWDCBTL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 21:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWDCBTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 21:19:10 -0400
Received: from cantor.suse.de ([195.135.220.2]:48541 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964802AbWDCBTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 21:19:09 -0400
From: Neil Brown <neilb@suse.de>
To: Marc Eshel <eshel@almaden.ibm.com>
Date: Mon, 3 Apr 2006 11:17:17 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17456.30621.579579.483287@cse.unsw.edu.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net
Subject: Re: [NFS] [PATCH] knfsd: Correct reserved reply space for read requests.
In-Reply-To: message from Marc Eshel on Thursday March 30
References: <1060330055350.25337@suse.de>
	<OF66A2887E.D01D36C5-ON88257141.0061C8EF-88257141.00626357@us.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday March 30, eshel@almaden.ibm.com wrote:
> Hi Neil
> Can we use this opportunity to change NFSSVC_MAXBLKSIZE from 32K to 64K to 
> match RPCSVC_MAXPAYLOAD. It makes real difference in I/O performance (we 
> will still be saving half the space we used to allocate :).
> Thanks, Marc. 

Maybe... but why not 128K ??

There is certainly room to increase NFSSVC_MAXBLKSIZE, but I feel that
it needs to be done together with a more detailed look at consequences
in the network layer, particularly TCP window sizes.  I wouldn't mind
making a CONFIG_ tunable without that detailed look, but making it a
fixed change I feel less comfortable about.

NeilBrown
