Return-Path: <linux-kernel-owner+w=401wt.eu-S932218AbXAIQbc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbXAIQbc (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbXAIQbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:31:32 -0500
Received: from pat.uio.no ([129.240.10.15]:35284 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932209AbXAIQbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:31:31 -0500
Subject: Re: [PATCH 01/24] Unionfs: Documentation
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jan Kara <jack@suse.cz>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
In-Reply-To: <20070109121552.GA1260@atrey.karlin.mff.cuni.cz>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	 <1168229596875-git-send-email-jsipek@cs.sunysb.edu>
	 <20070108111852.ee156a90.akpm@osdl.org>
	 <20070108231524.GA1269@filer.fsl.cs.sunysb.edu>
	 <20070109121552.GA1260@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 11:30:19 -0500
Message-Id: <1168360219.6054.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 25975AF9CCF03BA82A88B4F15AD462734792B184
X-UiO-SPAM-Test: 69.241.229.183 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 13:15 +0100, Jan Kara wrote:
> > On Mon, Jan 08, 2007 at 11:18:52AM -0800, Andrew Morton wrote:
> > > On Sun,  7 Jan 2007 23:12:53 -0500
> > > "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu> wrote:
> > > 
>   <snip>
> 
> > > > Any such change can cause Unionfs to oops, or stay
> > > > silent and even RESULT IN DATA LOSS.
> > > 
> > > With a rather rough user interface ;)
> > 
> > That statement is meant to scare people away from modifying the lower fs :)
> > I tortured unionfs quite a bit, and it can oops but it takes some effort.
>   But isn't it then potential DOS? If you happen to union two filesystems
> and an untrusted user has write access to both original filesystem and
> the union, then you say he'd be able to produce oops? That does not
> sound very secure to me... And if any secure use of unionfs requires
> limitting access to the original trees, then I think it's a good reason
> to implement it in unionfs itself. Just my 2 cents.

You mean somebody like, say, a perfectly innocent process working on the
NFS server or some other client that is oblivious to the existence of
unionfs stacks on your particular machine?
To me, this has always sounded like a showstopper for using unionfs with
a remote filesystem.

  Trond

