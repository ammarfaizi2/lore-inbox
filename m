Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264155AbUFCOiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUFCOiM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 10:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUFCO2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 10:28:16 -0400
Received: from [213.146.154.40] ([213.146.154.40]:45713 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264965AbUFCO0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 10:26:42 -0400
Date: Thu, 3 Jun 2004 15:26:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Peter J. Braam" <braam@clusterfs.com>, linux-kernel@vger.kernel.org,
       axboe@suse.de, kevcorry@us.ibm.com, arjanv@redhat.com,
       iro@parcelfarce.linux.theplanet.co.uk, trond.myklebust@fys.uio.no,
       anton@samba.org, lustre-devel@clusterfs.com
Subject: Re: [PATCH/RFC] Lustre VFS patch, version 2
Message-ID: <20040603142640.GA16837@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lars Marowsky-Bree <lmb@suse.de>,
	"Peter J. Braam" <braam@clusterfs.com>,
	linux-kernel@vger.kernel.org, axboe@suse.de, kevcorry@us.ibm.com,
	arjanv@redhat.com, iro@parcelfarce.linux.theplanet.co.uk,
	trond.myklebust@fys.uio.no, anton@samba.org,
	lustre-devel@clusterfs.com
References: <20040602231554.ADC7B3100AE@moraine.clusterfs.com> <20040603135952.GB16378@infradead.org> <20040603141922.GI4423@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040603141922.GI4423@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 04:19:22PM +0200, Lars Marowsky-Bree wrote:
> On 2004-06-03T14:59:52,
>    Christoph Hellwig <hch@infradead.org> said:
> 
> > > Well, how close are we now to this being acceptable?
> > As already mentioned above they're completely uninteresting without
> > actually getting the user in tree _and_ maintained there (unlike e.g.
> > intermezzo or coda that are creeping along).  I think based on those
> > patch we should be able to properly integrate intermezzo once 2.7 opens.
> 
> This is something I've got to disagree with.
> 
> First, Inter-mezzo is reasonably dead, from what I can see. As is Coda.
> You'll notice that the developers behind them have sort-of moved on to
> Lustre ;-)

Arggg, sorry.  Typo there.  It should have of course read

"I think based on those patches we should be able to properly integrate
LUSTRE once 2.7 opens"

.oO(/me looks for a brown paperbag to hide)

> The logic that _all_ modules and functionality need to be "in the tree"
> right from the start for hooks to be useful is flawed, I'm afraid. Pure
> horror that a proprietary cluster file system might also profit from it
> is not, exactly, a sound technical argument. (I can assure you I don't
> care at all for the proprietary cluster-fs.)

It's more about maintaince overhead.   Maintaining features without the
user direct at hand isn't going anywhere.  Especially when messing around
deeply in the VFS.  By your argumentation we should also throw in all the
mosix and openssi hooks because they could be possibly useful, no? ;-)

> Another example of this is the cache invalidation hook which we went
> through a few weeks ago too. Back then you complained about not having
> an Open Source user (because it was requested by IBM GPFS), and so
> GFS/OpenGFS chimed in - now it is the lack of an _in-tree_ Open Source
> user...

I was always arguing against the lack of an intree user mostly.  Lack of
something that could we could merge even in the future is even worse.

