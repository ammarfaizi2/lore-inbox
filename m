Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTH2S5h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbTH2S5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:57:36 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:45060
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261704AbTH2S53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:57:29 -0400
Date: Fri, 29 Aug 2003 11:57:28 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Shantanu Goel <sgoel01@yahoo.com>
Cc: Antonio Vargas <wind@cocodriloo.com>, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>,
       Marc-Christian Petersen <m.c.p@wolk-project.de>
Subject: Re: [VM PATCH] Faster reclamation of dirty pages and unused inode/dcache entries in 2.4.22
Message-ID: <20030829185728.GA3846@matchmail.com>
Mail-Followup-To: Shantanu Goel <sgoel01@yahoo.com>,
	Antonio Vargas <wind@cocodriloo.com>, linux-kernel@vger.kernel.org,
	Andrea Arcangeli <andrea@suse.de>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>
References: <20030829180623.GB27023@matchmail.com> <20030829184644.5968.qmail@web12802.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829184644.5968.qmail@web12802.mail.yahoo.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing AA & MCP]

> --- Mike Fedyk <mfedyk@matchmail.com> wrote:
> > But have you compared your patch with the VM patches
> > in -aa?  Will your
> > patch apply on -aa and make improvements there too?
> > 
> > In other words: Why would I want to use this patch
> > when I could use -aa?

On Fri, Aug 29, 2003 at 11:46:44AM -0700, Shantanu Goel wrote:
> I prefer to run stock kernels so I don't have as much
> experience with the -aa patches.  However, I took a
> look at the relevant code in 2.4.22pre7aa1 and I
> believe my patch should help there as well.  The
> writepage() and page rotation behaviour is similar to
> stock 2.4.22 though the inactive_list is per-classzone
> in -aa.  I am less sure about the inode/dcache part
> though under -aa.

You need to integrate with -aa on the VM.  It has been hard enough for
Andrea to get his stuff in, I doubt you will fair any better.

If your patch shows improvements when applied on -aa Andrea will probably
integrate it.

Marc/Andrea, what do you think?  Any holes to poke in this here patch?
