Return-Path: <linux-kernel-owner+w=401wt.eu-S1030273AbXAHWKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbXAHWKl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 17:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbXAHWKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 17:10:41 -0500
Received: from cs.columbia.edu ([128.59.16.20]:49818 "EHLO cs.columbia.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030247AbXAHWKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 17:10:40 -0500
Subject: Re: [PATCH 05/24] Unionfs: Copyup Functionality
From: Shaya Potter <spotter@cs.columbia.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
In-Reply-To: <20070108132947.6a8f9cf4.akpm@osdl.org>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	 <11682295971184-git-send-email-jsipek@cs.sunysb.edu>
	 <20070108132947.6a8f9cf4.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 17:00:15 -0500
Message-Id: <1168293615.9853.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.9.4 
Content-Transfer-Encoding: 7bit
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, X-Seen-By filter2.cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-08 at 13:29 -0800, Andrew Morton wrote:
> On Sun,  7 Jan 2007 23:12:57 -0500
> "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:
> 
> > From: Josef "Jeff" Sipek <jsipek@cs.sunysb.edu>
> > 
> > This patch contains the functions used to perform copyup operations in unionfs.
> 
> What is a copyup operation and why does it exist?
> 
> It seems to be copying the entire contents of certain files.  That's not a
> thing I'd have expected to see in a union filesystem.  Explain it all,
> please?  (Somewhere where the info will be retained for posterity - a
> random email is good, but not sufficient...)

to do the random e-mail, it's because it just doesn't union
"directories", but lets you assign read-write, read-only properties to
them.

If you try to modify a file on a read-only layer, it will be copied to
the top most layer (has to be read-write) and then modified.  It can be
slow though (imagine modifying a 1GB file).

