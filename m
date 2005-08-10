Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965067AbVHJLLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVHJLLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 07:11:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbVHJLLS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 07:11:18 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42216 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965067AbVHJLLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 07:11:18 -0400
Date: Wed, 10 Aug 2005 12:11:10 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050810111110.GA6878@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lars Marowsky-Bree <lmb@suse.de>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	David Teigland <teigland@redhat.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org, linux-cluster@redhat.com
References: <20050802071828.GA11217@redhat.com> <20050809152045.GT29811@parcelfarce.linux.theplanet.co.uk> <20050810070309.GA2415@infradead.org> <20050810103041.GB4634@marowsky-bree.de> <20050810103256.GA6127@infradead.org> <20050810103424.GC4634@marowsky-bree.de> <20050810105450.GA6519@infradead.org> <20050810110259.GE4634@marowsky-bree.de> <20050810110511.GA6728@infradead.org> <20050810110917.GG4634@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050810110917.GG4634@marowsky-bree.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 01:09:17PM +0200, Lars Marowsky-Bree wrote:
> On 2005-08-10T12:05:11, Christoph Hellwig <hch@infradead.org> wrote:
> 
> > > What would a syntax look like which in your opinion does not remove
> > > totally valid symlink targets for magic mushroom bullshit? Prefix with
> > > // (which, according to POSIX, allows for implementation-defined
> > > behaviour)? Something else, not allowed in a regular pathname?
> > None.  just don't do it.  Use bindmount, they're cheap and have sane
> > defined semtantics.
> 
> So for every directoy hiearchy on a shared filesystem, each user needs
> to have the complete list of bindmounts needed, and automatically resync
> that across all nodes when a new one is added or removed? And then have
> that executed by root, because a regular user can't?

Do it in an initscripts and let users simply not do it, they shouldn't
even know what kind of filesystem they are on.

