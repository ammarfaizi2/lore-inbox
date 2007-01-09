Return-Path: <linux-kernel-owner+w=401wt.eu-S932206AbXAIQ1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbXAIQ1e (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbXAIQ1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:27:34 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:62017 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202AbXAIQ1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:27:33 -0500
Subject: Re: Finding hardlinks
From: Steven Rostedt <rostedt@goodmis.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@ucw.cz, mikulas@artax.karlin.mff.cuni.cz, matthew@wil.cx,
       bhalevy@panasas.com, arjan@infradead.org, jaharkes@cs.cmu.edu,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       nfsv4@ietf.org
In-Reply-To: <E1H3tAe-00052Q-00@dorka.pomaz.szeredi.hu>
References: <20070103135455.GA24620@parisc-linux.org>
	 <E1H28Oi-0003kw-00@dorka.pomaz.szeredi.hu>
	 <20070104225929.GC8243@elf.ucw.cz>
	 <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu> <20070105131235.GB4662@ucw.cz>
	 <E1H2pXI-0007jY-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.64.0701051502120.28914@artax.karlin.mff.cuni.cz>
	 <E1H2qhP-0007qc-00@dorka.pomaz.szeredi.hu>
	 <Pine.LNX.4.64.0701080652220.3506@artax.karlin.mff.cuni.cz>
	 <E1H3qCY-0004mP-00@dorka.pomaz.szeredi.hu>
	 <20070108112916.GB25857@elf.ucw.cz>
	 <E1H3tAe-00052Q-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Tue, 09 Jan 2007 11:26:25 -0500
Message-Id: <1168359985.7817.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-08 at 13:00 +0100, Miklos Szeredi wrote:

> > 50% probability of false positive on 4G files seems like very ugly
> > design problem to me.
> 
> 4 billion files, each with more than one link is pretty far fetched.
> And anyway, filesystems can take steps to prevent collisions, as they
> do currently for 32bit st_ino, without serious difficulties
> apparently.

Maybe not 4 billion files, but you can get a large number of >1 linked
files, when you copy full directories with "cp -rl".  Which I do a lot
when developing. I've done that a few times with the Linux tree.  Given
other utils that copy as hard links, can perhaps make a 4 billion number
of files with >1 link possible, and perhaps likely in the near future.

-- Steve


