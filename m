Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTIBSI2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 14:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264034AbTIBSHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 14:07:01 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:19214 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263990AbTIBSDG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 14:03:06 -0400
Date: Tue, 2 Sep 2003 19:02:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: andrew@lunn.ch, linux-kernel@vger.kernel.org, andrew.lunn@ascom.ch
Subject: Re: 2.6-test4 Traditional pty and devfs
Message-ID: <20030902190258.A15601@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, andrew@lunn.ch,
	linux-kernel@vger.kernel.org, andrew.lunn@ascom.ch
References: <20030902104212.GA23978@londo.lunn.ch> <20030902150808.A7388@infradead.org> <20030902102141.44dc7297.akpm@osdl.org> <20030902184236.A14715@infradead.org> <20030902104340.1e360f1b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030902104340.1e360f1b.akpm@osdl.org>; from akpm@osdl.org on Tue, Sep 02, 2003 at 10:43:40AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 10:43:40AM -0700, Andrew Morton wrote:
> > That's the magic use uid/gid of the process calling devfs_Register flag
> > I killed.  With a big HEADSUP and explanation on lkml..
> 
> So what is the impact here?  That libc5 will break if the user is using
> devfs and old-style pty's?

If he removed the pt_chown logic that is present with a stock libc5,
yes.  I wouldn't know why someone would do that, though.

That's why I'm really keen on knowing how the system of the bugreporter
looks - this shouldn't happen without a very strange setup.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, Sep 02, 2003 at 10:43:40AM -0700, Andrew Morton wrote:
> > That's the magic use uid/gid of the process calling devfs_Register flag
> > I killed.  With a big HEADSUP and explanation on lkml..
> 
> So what is the impact here?  That libc5 will break if the user is using
> devfs and old-style pty's?

If he removed the pt_chown logic that is present with a stock libc5,
yes.  I wouldn't know why someone would do that, though.

That's why I'm really keen on knowing how the system of the bugreporter
looks - this shouldn't happen without a very strange setup.
