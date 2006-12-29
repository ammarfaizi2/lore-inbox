Return-Path: <linux-kernel-owner+w=401wt.eu-S1751520AbWL2Kew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbWL2Kew (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 05:34:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWL2Kew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 05:34:52 -0500
Received: from pat.uio.no ([129.240.10.15]:44844 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751079AbWL2Kev (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 05:34:51 -0500
Subject: Re: Finding hardlinks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Arjan van de Ven <arjan@infradead.org>, Benny Halevy <bhalevy@panasas.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
In-Reply-To: <Pine.LNX.4.64.0612281909200.2960@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>
	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
	 <1166869106.3281.587.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
	 <4593890C.8030207@panasas.com>
	 <1167300352.3281.4183.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612281909200.2960@artax.karlin.mff.cuni.cz>
Content-Type: text/plain
Date: Fri, 29 Dec 2006 11:34:35 +0100
Message-Id: <1167388475.6106.51.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=failed, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 6F67C93B556E7C92F9A51CAF27AF8E47DF118A28
X-UiO-SPAM-Test: 83.109.147.16 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-28 at 19:14 +0100, Mikulas Patocka wrote:
> Why don't you rip off the support for colliding inode number from the 
> kernel at all (i.e. remove iget5_locked)?
> 
> It's reasonable to have either no support for colliding ino_t or full 
> support for that (including syscalls that userspace can use to work with 
> such filesystem) --- but I don't see any point in having half-way support 
> in kernel as is right now.

What would ino_t have to do with inode numbers? It is only used as a
hash table lookup. The inode number is set in the ->getattr() callback.

Cheers
  Trond

