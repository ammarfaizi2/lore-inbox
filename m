Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750781AbVHXJA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750781AbVHXJA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 05:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbVHXJA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 05:00:28 -0400
Received: from adsl-266.mirage.euroweb.hu ([193.226.239.10]:5648 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750781AbVHXJA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 05:00:27 -0400
To: hch@infradead.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
In-reply-to: <20050824073334.GB24513@infradead.org> (message from Christoph
	Hellwig on Wed, 24 Aug 2005 08:33:34 +0100)
Subject: Re: [PATCH 6/8] remove duplicated sys_open32() code from 64bit archs
References: <E1E7fHs-0006DO-00@dorka.pomaz.szeredi.hu> <E1E7fJu-0006EB-00@dorka.pomaz.szeredi.hu> <E1E7fMD-0006En-00@dorka.pomaz.szeredi.hu> <E1E7fPj-0006Fq-00@dorka.pomaz.szeredi.hu> <E1E7fSd-0006Gr-00@dorka.pomaz.szeredi.hu> <E1E7fVJ-0006HK-00@dorka.pomaz.szeredi.hu> <E1E7fcN-0006IR-00@dorka.pomaz.szeredi.hu> <20050824073334.GB24513@infradead.org>
Message-Id: <E1E7r79-00074o-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 24 Aug 2005 11:00:07 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Aug 23, 2005 at 10:43:35PM +0200, Miklos Szeredi wrote:
> > 64 bit architectures all implement their own compatibility sys_open(),
> > when in fact the difference is simply not forcing the O_LARGEFILE
> > flag.  So use the a common function instead.
> 
> Traditional naming would be just do_open(), but else this looks very nice.

do_open() was my first choice, but it caused a number of clashes.

Miklos
