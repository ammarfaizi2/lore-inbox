Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVIEHud@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVIEHud (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 03:50:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVIEHuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 03:50:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:8388 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932352AbVIEHua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 03:50:30 -0400
Date: Mon, 5 Sep 2005 15:55:28 +0800
From: David Teigland <teigland@redhat.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS, what's remaining
Message-ID: <20050905075528.GB17607@redhat.com>
References: <20050901104620.GA22482@redhat.com> <1125574523.5025.10.camel@laptopd505.fenrus.org> <20050905054348.GC11337@redhat.com> <84144f02050904233274d45230@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84144f02050904233274d45230@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 09:32:59AM +0300, Pekka Enberg wrote:
> On Thu, Sep 01, 2005 at 01:35:23PM +0200, Arjan van de Ven wrote:
> > > +void gfs2_glock_hold(struct gfs2_glock *gl)
> > > +{
> > > +     glock_hold(gl);
> > > +}
> > >
> > > eh why?
> 
> On 9/5/05, David Teigland <teigland@redhat.com> wrote:
> > You removed the comment stating exactly why, see below.  If that's not a
> > accepted technique in the kernel, say so and I'll be happy to change it
> > here and elsewhere.
> 
> Is there a reason why users of gfs2_glock_hold() cannot use
> glock_hold() directly?

Either set could be trivially removed.  It's such an insignificant issue
that I've removed glock_hold and put.  For the record,

within glock.c we consistently paired inlined versions of:
	glock_hold()
	glock_put()

we wanted external versions to be appropriately named so we had:
	gfs2_glock_hold()
	gfs2_glock_put()

still not sure if that technique is acceptable in this crowd or not.
Dave

