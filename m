Return-Path: <linux-kernel-owner+w=401wt.eu-S932240AbXAIRES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbXAIRES (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbXAIRES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:04:18 -0500
Received: from pat.uio.no ([129.240.10.15]:57800 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932240AbXAIRER (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:04:17 -0500
Subject: Re: [PATCH 01/24] Unionfs: Documentation
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: Jan Kara <jack@suse.cz>, Josef Sipek <jsipek@fsl.cs.sunysb.edu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, viro@ftp.linux.org.uk,
       torvalds@osdl.org, mhalcrow@us.ibm.com,
       David Quigley <dquigley@fsl.cs.sunysb.edu>,
       Erez Zadok <ezk@cs.sunysb.edu>
In-Reply-To: <1168360893.5024.38.camel@localhost.localdomain>
References: <1168229596580-git-send-email-jsipek@cs.sunysb.edu>
	 <1168229596875-git-send-email-jsipek@cs.sunysb.edu>
	 <20070108111852.ee156a90.akpm@osdl.org>
	 <20070108231524.GA1269@filer.fsl.cs.sunysb.edu>
	 <20070109121552.GA1260@atrey.karlin.mff.cuni.cz>
	 <1168360219.6054.14.camel@lade.trondhjem.org>
	 <1168360893.5024.38.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 12:03:51 -0500
Message-Id: <1168362231.6054.38.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: DE54CD7666AED1B9C775EF206B62639DABF5471E
X-UiO-SPAM-Test: 69.241.229.183 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-09 at 11:41 -0500, Shaya Potter wrote:
> On Tue, 2007-01-09 at 11:30 -0500, Trond Myklebust wrote:
> > You mean somebody like, say, a perfectly innocent process working on the
> > NFS server or some other client that is oblivious to the existence of
> > unionfs stacks on your particular machine?
> > To me, this has always sounded like a showstopper for using unionfs with
> > a remote filesystem.
> 
> Again, what about fibre channel support?  Imagine I have multiple blades
> connected to a SAN.  For whatever reason I format the san w/ ext3 (I've
> actually done this when we didn't need sharing, just needed a huge disk,
> for instance for doing benchmarks where I needed a large data set that
> was bigger than the 40GB disk that the blades came with).  I better not
> touch that disk from any of the other blades.
> 
> All you are saying is unionfs should always make sure its data is sane,
> never make assumptions about it being correct.
> 
> Put it this way, imagine I have an ext3 fs on a SAN, I can only use it
> frm one machine.  Lets say I want to be smart and mount the FS read-only
> from another machine,  should I have any expectation that it will work?
> Nope.  
> 
> Now, under what conditions can one expect unionfs to work?  Basically,
> where the underlying FS isn't being modified (though possible others).
> Is that a reasonable condition.  I believe so.  If you disobey the
> condition, the machine shouldn't oops, but it should detect it and tell
> you and shut down usage of the FS.

I'm saying that at the very least it should not Oops in these
situations. As to whether or not they are something you want to handle
more gracefully, that is up to you, but Oopses are definitely a
showstopper.

Trond

