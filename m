Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264927AbUBABtA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 20:49:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUBABtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 20:49:00 -0500
Received: from dp.samba.org ([66.70.73.150]:43491 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264927AbUBABs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 20:48:58 -0500
Date: Sun, 1 Feb 2004 12:46:54 +1100
From: Anton Blanchard <anton@samba.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, nathans@sgi.com
Subject: Re: 2.6.2-rc2 nfsd+xfs spins in i_size_read()
Message-ID: <20040201014654.GA22694@krispykreme>
References: <bv8qr7$m2v$1@news.cistron.nl> <20040128222521.75a7d74f.akpm@osdl.org> <20040130202155.GM25833@drinkel.cistron.nl> <20040130221353.GO25833@drinkel.cistron.nl> <20040130143459.5eed31f0.akpm@osdl.org> <20040130225353.A26383@infradead.org> <20040130151316.40d70ed3.akpm@osdl.org> <20040131012507.GQ25833@drinkel.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131012507.GQ25833@drinkel.cistron.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +	if (down_trylock(&inode->i_sem) == 0) {
> > +		if (count < 10) {
> 
> You want to set this to 100 at least, since at boot time the message
> happens _often_ even without XFS.

You could also just printk_ratelimit it :)

Anton
