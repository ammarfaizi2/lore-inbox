Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbTH2Sq4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbTH2Sq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:46:56 -0400
Received: from web12802.mail.yahoo.com ([216.136.174.37]:62122 "HELO
	web12802.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261548AbTH2Sqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:46:45 -0400
Message-ID: <20030829184644.5968.qmail@web12802.mail.yahoo.com>
Date: Fri, 29 Aug 2003 11:46:44 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: [VM PATCH] Faster reclamation of dirty pages and unused inode/dcache entries in 2.4.22
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Antonio Vargas <wind@cocodriloo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030829180623.GB27023@matchmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I prefer to run stock kernels so I don't have as much
experience with the -aa patches.  However, I took a
look at the relevant code in 2.4.22pre7aa1 and I
believe my patch should help there as well.  The
writepage() and page rotation behaviour is similar to
stock 2.4.22 though the inactive_list is per-classzone
in -aa.  I am less sure about the inode/dcache part
though under -aa.

--- Mike Fedyk <mfedyk@matchmail.com> wrote:
> On Fri, Aug 29, 2003 at 10:55:44AM -0700, Shantanu
> Goel wrote:
> > I am not very knowledgeable about
> micro-optimizations.
> >  I'll take your word for it. ;-)  What interests
> me
> > more is whether others notice any performance
> > improvement under swapout with this patch given
> that
> > is on the order of milliseconds.
> 
> But have you compared your patch with the VM patches
> in -aa?  Will your
> patch apply on -aa and make improvements there too?
> 
> In other words: Why would I want to use this patch
> when I could use -aa?
> 


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com
