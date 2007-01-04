Return-Path: <linux-kernel-owner+w=401wt.eu-S932333AbXADIhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbXADIhA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 03:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbXADIhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 03:37:00 -0500
Received: from pat.uio.no ([129.240.10.15]:41529 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932329AbXADIg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 03:36:59 -0500
Subject: Re: [nfsv4] RE: Finding hardlinks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Benny Halevy <bhalevy@panasas.com>
Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Miklos Szeredi <miklos@szeredi.hu>,
       linux-kernel@vger.kernel.org, nfsv4@ietf.org,
       linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@poochiereds.net>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <459BA30A.4020809@panasas.com>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	 <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
	 <20061221185850.GA16807@delft.aura.cs.cmu.edu>
	 <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz>
	 <1166869106.3281.587.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz>
	 <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net>
	 <4593DEF8.5020609@panasas.com>
	 <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz>
	 <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com>
	 <1167388129.6106.45.camel@lade.trondhjem.org>
	 <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com>
	 <1167780097.6090.104.camel@lade.trondhjem.org>
	 <459BA30A.4020809@panasas.com>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 09:36:36 +0100
Message-Id: <1167899796.6046.11.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=disabled, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: FA51EB85769BC22C81BFAA5C267EDD402F88FADE
X-UiO-SPAM-Test: 83.109.147.16 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-03 at 14:35 +0200, Benny Halevy wrote:
> I sincerely expect you or anybody else for this matter to try to provide
> feedback and object to the protocol specification in case they disagree
> with it (or think it's ambiguous or self contradicting) rather than ignoring
> it and implementing something else. I think we're shooting ourselves in the
> foot when doing so and it is in our common interest to strive to reach a
> realistic standard we can all comply with and interoperate with each other.

You are reading the protocol wrong in this case.

While the protocol does allow the server to implement the behaviour that
you've been advocating, it in no way mandates it. Nor does it mandate
that the client should gather files with the same (fsid,fileid) and
cache them together. Those are issues to do with _implementation_, and
are thus beyond the scope of the IETF.

In our case, the client will ignore the unique_handles attribute. It
will use filehandles as our inode cache identifier. It will not jump
through hoops to provide caching semantics that go beyond close-to-open
for servers that set unique_handles to "false".

Trond

