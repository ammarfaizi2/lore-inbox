Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261782AbVAZJzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbVAZJzM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 04:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVAZJzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 04:55:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34224 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261782AbVAZJzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 04:55:08 -0500
Date: Wed, 26 Jan 2005 09:55:04 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, viro@zenII.uk.linux.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: make flock_lock_file_wait static
Message-ID: <20050126095504.GA7542@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	viro@zenII.uk.linux.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <1105310650.11315.19.camel@lade.trondhjem.org> <1105345168.4171.11.camel@laptopd505.fenrus.org> <1105346324.4171.16.camel@laptopd505.fenrus.org> <1105367014.11462.13.camel@lade.trondhjem.org> <1105432299.3917.11.camel@laptopd505.fenrus.org> <1105471004.12005.46.camel@lade.trondhjem.org> <1105472182.3917.49.camel@laptopd505.fenrus.org> <20050125185812.GA1499@us.ibm.com> <20050126094308.GA7326@infradead.org> <20050126095131.GF8859@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050126095131.GF8859@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 09:51:31AM +0000, Al Viro wrote:
> On Wed, Jan 26, 2005 at 09:43:08AM +0000, Christoph Hellwig wrote:
> > > o	vfs_follow_link(): used to interpret symbolic links, which
> > > 	might point outside of SAN Filesystem.
> > 
> > This one is going away very soon, including the whole old-style
> > ->follow_link support - for technical reasons.
> 
> Not really.  In some cases it _is_ legitimate.  Trivial example:
> /proc/self.

Which is an extreme special case an not modular.
