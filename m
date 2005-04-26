Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbVDZJUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbVDZJUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 05:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVDZJUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 05:20:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32175 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261422AbVDZJTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 05:19:40 -0400
Date: Tue, 26 Apr 2005 10:19:21 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: jamie@shareable.org, linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
       viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050426091921.GA29810@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, jamie@shareable.org,
	linuxram@us.ibm.com, 7eggert@gmx.de, bulb@ucw.cz,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <3WWGj-3nm-3@gated-at.bofh.it> <3WWQ9-3uA-15@gated-at.bofh.it> <3WWZG-3AC-7@gated-at.bofh.it> <3X630-2qD-21@gated-at.bofh.it> <3X8HA-4IH-15@gated-at.bofh.it> <3Xagd-5Wb-1@gated-at.bofh.it> <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org> <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 11:16:18AM +0200, Miklos Szeredi wrote:
> The most important difference between orinary filesystems and FUSE is
> the fact, that the filesystem data/metadata is provided by a userspace
> process run with the privileges of the mount "owner" instead of the
> kernel, or some remote entity usually running with elevated
> privileges.

define "mount owner".  Right now mount requires CAP_SYS_ADMIN which means
fairly privilegued.  Having some kind of user mounts would be nice, but
needs a fair amount of auditing first.

