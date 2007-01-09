Return-Path: <linux-kernel-owner+w=401wt.eu-S932204AbXAITxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbXAITxN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 14:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932335AbXAITxN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 14:53:13 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:38399 "EHLO
	janus.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932204AbXAITxM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 14:53:12 -0500
Date: Tue, 9 Jan 2007 20:53:10 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, pavel@ucw.cz,
       mikulas@artax.karlin.mff.cuni.cz, matthew@wil.cx, bhalevy@panasas.com,
       arjan@infradead.org, jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, nfsv4@ietf.org
Subject: Re: Finding hardlinks
Message-ID: <20070109195310.GA10572@janus>
References: <E1H2kfa-0007Jl-00@dorka.pomaz.szeredi.hu> <20070105131235.GB4662@ucw.cz> <E1H2pXI-0007jY-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701051502120.28914@artax.karlin.mff.cuni.cz> <E1H2qhP-0007qc-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0701080652220.3506@artax.karlin.mff.cuni.cz> <E1H3qCY-0004mP-00@dorka.pomaz.szeredi.hu> <20070108112916.GB25857@elf.ucw.cz> <E1H3tAe-00052Q-00@dorka.pomaz.szeredi.hu> <1168359985.7817.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168359985.7817.4.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-BotBait: val@frankvm.com, kuil@frankvm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 11:26:25AM -0500, Steven Rostedt wrote:
> On Mon, 2007-01-08 at 13:00 +0100, Miklos Szeredi wrote:
> 
> > > 50% probability of false positive on 4G files seems like very ugly
> > > design problem to me.
> > 
> > 4 billion files, each with more than one link is pretty far fetched.
> > And anyway, filesystems can take steps to prevent collisions, as they
> > do currently for 32bit st_ino, without serious difficulties
> > apparently.
> 
> Maybe not 4 billion files, but you can get a large number of >1 linked
> files, when you copy full directories with "cp -rl".

Yes but "cp -rl" is typically done by _developers_ and they tend to
have a better understanding of this (uh, at least within linux context
I hope so).

Also, just adding hard-links doesn't increase the number of inodes.

-- 
Frank
