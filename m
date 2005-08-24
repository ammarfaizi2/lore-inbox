Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVHXJFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVHXJFi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 05:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVHXJFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 05:05:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42209 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750801AbVHXJFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 05:05:37 -0400
Date: Wed, 24 Aug 2005 10:05:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] remove duplicated sys_open32() code from 64bit archs
Message-ID: <20050824090536.GA26447@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu> <E1E7fMD-0006En-00@dorka.pomaz.szeredi.hu> <E1E7fPj-0006Fq-00@dorka.pomaz.szeredi.hu> <E1E7fSd-0006Gr-00@dorka.pomaz.szeredi.hu> <E1E7fVJ-0006HK-00@dorka.pomaz.szeredi.hu> <E1E7fcN-0006IR-00@dorka.pomaz.szeredi.hu> <20050824073334.GB24513@infradead.org> <E1E7r79-00074o-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1E7r79-00074o-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 11:00:07AM +0200, Miklos Szeredi wrote:
> > On Tue, Aug 23, 2005 at 10:43:35PM +0200, Miklos Szeredi wrote:
> > > 64 bit architectures all implement their own compatibility sys_open(),
> > > when in fact the difference is simply not forcing the O_LARGEFILE
> > > flag.  So use the a common function instead.
> > 
> > Traditional naming would be just do_open(), but else this looks very nice.
> 
> do_open() was my first choice, but it caused a number of clashes.

ok, let's leave it the way it is..
