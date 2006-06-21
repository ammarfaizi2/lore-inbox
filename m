Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932479AbWFUIPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbWFUIPi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 04:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbWFUIPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 04:15:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31135 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932479AbWFUIPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 04:15:38 -0400
Subject: Re: 2.6.17-rc6-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060621062346.GA10637@redhat.com>
References: <20060607104724.c5d3d730.akpm@osdl.org>
	 <20060608050047.GB16729@redhat.com>
	 <1150825349.2891.219.camel@laptopd505.fenrus.org>
	 <20060621062346.GA10637@redhat.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 10:15:33 +0200
Message-Id: <1150877733.3057.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 02:23 -0400, Dave Jones wrote:
> On Tue, Jun 20, 2006 at 07:42:29PM +0200, Arjan van de Ven wrote:
>  > On Thu, 2006-06-08 at 01:00 -0400, Dave Jones wrote:
>  > > On Wed, Jun 07, 2006 at 10:47:24AM -0700, Andrew Morton wrote:
>  > >  > 
>  > >  > ftp://ftp.kernel.org/pub/linux/kernel/peopleD/akpm/patches/2.6/2.6.17-rc6/2.6.17-rc6-mm1/
>  > >  > 
>  > >  > - Many more lockdep updates
>  > > 
>  > > Needs more.
>  > > 
>  > > ====================================
>  > > [ BUG: possible deadlock detected! ]
>  > > ------------------------------------
>  > > nfsd/11429 is trying to acquire lock:
>  > >  (&inode->i_mutex){--..}, at: [<c032286a>] mutex_lock+0x21/0x24
>  > > 
>  > > but task is already holding lock:
>  > >  (&inode->i_mutex){--..}, at: [<c032286a>] mutex_lock+0x21/0x24
>  > > 
>  > > which could potentially lead to deadlocks!
>  > 
>  > Does this fix it for you? (it fixes the case for me)
> 
> Hmm. This makes things drastically worse for me. Now it hangs during NFS startup.

hmm that's highly unexpected


