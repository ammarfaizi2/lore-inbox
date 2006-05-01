Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750718AbWEASJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWEASJU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 14:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWEASJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 14:09:20 -0400
Received: from mail.suse.de ([195.135.220.2]:52361 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750718AbWEASJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 14:09:18 -0400
Date: Mon, 1 May 2006 11:07:37 -0700
From: Greg KH <greg@kroah.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Arjan van de Ven <arjan@infradead.org>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4a/4] MultiAdmin LSM (LKCS'ed)
Message-ID: <20060501180737.GA15184@kroah.com>
References: <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr> <1145462454.3085.62.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr> <20060419201154.GB20545@kroah.com> <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr> <20060421150529.GA15811@kroah.com> <Pine.LNX.4.61.0605011543180.31804@yvahk01.tjqt.qr> <Pine.LNX.4.61.0605011801400.32172@yvahk01.tjqt.qr> <20060501164740.GA8995@kroah.com> <Pine.LNX.4.61.0605011941220.3919@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0605011941220.3919@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 07:42:33PM +0200, Jan Engelhardt wrote:
> 
> >asm #include goes last.
> 
> How come?

Just the standard style.

> >> +static inline int range_intersect_wrt(uid_t, uid_t, uid_t, uid_t);
> >
> >inline functions don't need definitions like this.
> 
> If memory serves right, callees mentioned below their callers need a 
> prototype.

You can't have a inline function with a prototype :)

> >> +static gid_t Supergid = -1, Subgid = -1;
> >> +static uid_t Superuid_start = 0, Superuid_end = 0,
> >> +    Subuid_start = -1, Subuid_end = -1,
> >> +    Netuid = -1, Wrtuid_start = -1, Wrtuid_end = -1;
> >> +static int Secondary = 0;
> >
> >Variables do not have capital letters.
> 
> Who has, besides macros, if anything?

nothing.

thanks,

greg k-h
