Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVDZKlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVDZKlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 06:41:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVDZKkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 06:40:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10673 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261469AbVDZKjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 06:39:19 -0400
Date: Tue, 26 Apr 2005 11:38:59 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu,
       jamie@shareable.org, linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050426103859.GA31468@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, miklos@szeredi.hu,
	jamie@shareable.org, linuxram@us.ibm.com, 7eggert@gmx.de,
	bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426030010.63757c8c.akpm@osdl.org> <20050426100412.GA30762@infradead.org> <20050426031414.260568b5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426031414.260568b5.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 03:14:14AM -0700, Andrew Morton wrote:
> That's one of the major points of FUSE, isn't it?  So that unprivileged
> users can do interesting things.
> 
> Or are you saying that that's a desirable objective, but it should be
> implemented differently?

It's a desirable objective, but the implementation is wrong.  If we have
a user mount that must be known to the VFS so that the VFS can enforce
the right restrictions instead of leaving various crude hacks in lowlevel
filesystem drivers.  Especially as fuse isn't the only filesystem for which
this makes sense - smbfs or v9fs want the same features aswell

