Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWE3MOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWE3MOT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 08:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWE3MOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 08:14:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24749 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751426AbWE3MOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 08:14:19 -0400
Subject: Re: [patch, -rc5-mm1] lock validator, fix NULL type->name bug
From: Arjan van de Ven <arjan@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1148990725.8610.1.camel@homer>
References: <20060530022925.8a67b613.akpm@osdl.org>
	 <20060530111138.GA5078@elte.hu>  <1148990326.7599.4.camel@homer>
	 <1148990725.8610.1.camel@homer>
Content-Type: text/plain
Date: Tue, 30 May 2006 14:14:16 +0200
Message-Id: <1148991256.3636.55.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-30 at 14:05 +0200, Mike Galbraith wrote:
> On Tue, 2006-05-30 at 13:58 +0200, Mike Galbraith wrote:
> 
> > =====================================================
> > [ BUG: possible circular locking deadlock detected! ]
> > -----------------------------------------------------
> > mount/2545 is trying to acquire lock:
> >  (&ni->mrec_lock){--..}, at: [<b13d1563>] mutex_lock+0x8/0xa
> > 
> > ...and deadlocks.
> > 
> > I'll try to find out what it hates.
> 
> It hates NTFS.


hummm. NTFS does really really weird things with mutexes...
can you try to enable the mutex debugging config option to see if that
triggers anything?

