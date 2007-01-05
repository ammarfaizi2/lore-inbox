Return-Path: <linux-kernel-owner+w=401wt.eu-S1161155AbXAEQ4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161155AbXAEQ4z (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 11:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161154AbXAEQ4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 11:56:54 -0500
Received: from pat.uio.no ([129.240.10.15]:40856 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161152AbXAEQ4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 11:56:53 -0500
Subject: Re: [nfsv4] RE: Finding hardlinks
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nicolas Williams <Nicolas.Williams@sun.com>
Cc: Benny Halevy <bhalevy@panasas.com>, Jan Harkes <jaharkes@cs.cmu.edu>,
       Miklos Szeredi <miklos@szeredi.hu>, nfsv4@ietf.org,
       linux-kernel@vger.kernel.org,
       Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
       linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@poochiereds.net>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <20070105164008.GA1010@binky.Central.Sun.COM>
References: <4593C524.8070209@poochiereds.net>
	 <4593DEF8.5020609@panasas.com>
	 <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz>
	 <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com>
	 <1167388129.6106.45.camel@lade.trondhjem.org>
	 <E472128B1EB43941B4E7FB268020C89B149CF1@riverside.int.panasas.com>
	 <1167780097.6090.104.camel@lade.trondhjem.org>
	 <459BA30A.4020809@panasas.com>
	 <1167899796.6046.11.camel@lade.trondhjem.org>
	 <459CD11E.3000200@panasas.com>
	 <20070105164008.GA1010@binky.Central.Sun.COM>
Content-Type: text/plain
Date: Fri, 05 Jan 2007 17:56:24 +0100
Message-Id: <1168016184.6050.71.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.3, required=12.0, autolearn=disabled, AWL=1.667,UIO_MAIL_IS_INTERNAL=-5)
X-UiO-Scanned: 003C39055A0D86C106D4318399B8A57DB9593F76
X-UiO-SPAM-Test: 83.109.170.63 spam_score -32 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 0 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2007-01-05 at 10:40 -0600, Nicolas Williams wrote:
> What I don't understand is why getting the fileid is so hard -- always
> GETATTR when you GETFH and you'll be fine.  I'm guessing that's not as
> difficult as it is to maintain a hash table of fileids.

You've been sleeping in class. We always try to get the fileid together
with the GETFH. The irritating bit is having to redo a GETATTR using the
old filehandle in order to figure out if the 2 filehandles refer to the
same file. Unlike filehandles, fileids can be reused.

Then there is the point of dealing with that servers can (and do!)
actually lie to you.

Trond

