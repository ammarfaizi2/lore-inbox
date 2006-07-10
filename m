Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWGJVMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWGJVMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 17:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbWGJVMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 17:12:17 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:2493 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S964854AbWGJVMR
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 17:12:17 -0400
Date: Mon, 10 Jul 2006 15:12:15 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, "Vladimir V. Saveliev" <vs@namesys.com>,
       hch@infradead.org, Linux-Kernel@vger.kernel.org,
       reiserfs-dev@namesys.com
Subject: Re: [PATCH 1/2] batch-write.patch
Message-ID: <20060710211215.GK15380@schatzie.adilger.int>
Mail-Followup-To: Hans Reiser <reiser@namesys.com>,
	Andrew Morton <akpm@osdl.org>,
	"Vladimir V. Saveliev" <vs@namesys.com>, hch@infradead.org,
	Linux-Kernel@vger.kernel.org, reiserfs-dev@namesys.com
References: <44A42750.5020807@namesys.com> <20060629185017.8866f95e.akpm@osdl.org> <1152011576.6454.36.camel@tribesman.namesys.com> <20060704114836.GA1344@infradead.org> <44AAA8ED.5030906@namesys.com> <20060704151832.9f2d87b3.akpm@osdl.org> <1152117935.6337.48.camel@tribesman.namesys.com> <20060705122615.3a4fca06.akpm@osdl.org> <44AC9865.7040808@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44AC9865.7040808@namesys.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
X-SystemSpamProbe: GOOD 0.0000010 cb70bc8682dc9c05a204342c53a685bc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 05, 2006  21:58 -0700, Hans Reiser wrote:
> Reiser4, FUSE, maybe XFS, and GFS2.  Andreas, your support had
> conditions, so I will not characterize for you whether you said Lustre
> or you would like it.  Andreas, could you look at the patch and see what
> you think?

Lustre definitely wants to be able to aggregate IOs into larger chunks
wherever possible.  Having interfaces that allow this instead of going
through page-at-a-time interfaces is definitely a win.  As it stands
now we have to avoid the VFS or otherwise have back-channel information
in order to ensure that large IOs remain large.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

