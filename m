Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbTKZX3w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 18:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264399AbTKZX3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 18:29:51 -0500
Received: from ns.suse.de ([195.135.220.2]:50656 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264398AbTKZX3u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 18:29:50 -0500
Date: Thu, 27 Nov 2003 00:29:47 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fire Engine??
Message-Id: <20031127002947.2d731219.ak@suse.de>
In-Reply-To: <20031126151352.160b4734.davem@redhat.com>
References: <BAY1-DAV15JU71pROHD000040e2@hotmail.com.suse.lists.linux.kernel>
	<20031125183035.1c17185a.davem@redhat.com.suse.lists.linux.kernel>
	<p73fzgbzca6.fsf@verdi.suse.de>
	<20031126113040.3b774360.davem@redhat.com>
	<3FC505F4.2010006@google.com>
	<20031126120316.3ee1d251.davem@redhat.com>
	<20031126232909.7e8a028f.ak@suse.de>
	<20031126143620.5229fb1f.davem@redhat.com>
	<20031126235641.36fd71c1.ak@suse.de>
	<20031126151352.160b4734.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003 15:13:52 -0800
"David S. Miller" <davem@redhat.com> wrote:

> On Wed, 26 Nov 2003 23:56:41 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > On Wed, 26 Nov 2003 14:36:20 -0800
> > "David S. Miller" <davem@redhat.com> wrote:
> > 
> > > I don't think this is acceptable.  It's important that all
> > > of the timestamps are as accurate as they were before.
> > 
> > I disagree on that. The window is small and slowing down 99.99999% of all 
> > users who never care about this for this extremely obscure
> > misdesigned API does not make  much sense to me.
> 
> We can't change behavior like this.  Every time we've tried to
> do it, we've been burnt.  Remember nonlocal-bind?

The behaviour is not really changed, just the precision of the timestamp
is temporarily (a few tens of ms on a busy network) worse. 

And the jitter in this timestamp is already higher than this when
you consider queueing delays and interrupt mitigation in the driver.

-Andi

