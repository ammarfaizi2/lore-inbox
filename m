Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVECUjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVECUjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 16:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVECUjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 16:39:07 -0400
Received: from thunk.org ([69.25.196.29]:18825 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261684AbVECUjE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 16:39:04 -0400
Date: Tue, 3 May 2005 16:38:42 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Davy Durham <pubaddr2@davyandbeth.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3 issue..
Message-ID: <20050503203842.GA17985@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
	Davy Durham <pubaddr2@davyandbeth.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <4270FA5B.5060609@davyandbeth.com> <20050428200908.GB6669@thunk.org> <20050428205536.GA2297@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050428205536.GA2297@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 04:55:36PM -0400, Lennart Sorensen wrote:
> 
> I think I have seen this once or twice in the past.  A reboot always
> made it go away and it didn't seem to come back.  fsck never showed
> anything so I assumed it was just the kernel having lost its mind about
> the state of the FS.
> 
> I think I was using 2.4.18 or so at the time I last saw it.  It is quite
> a while ago but it was ext3 as well as far as I recall.

That's a different problem; in this case apparently the corruption is
extending to the on-disk superblock accounting information (so fsck is
detecting evidence of it).  Fortunately this sort of corruption won't
cause data loss, but we should figure out what the heck is going on.

						- Ted
