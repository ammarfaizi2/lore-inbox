Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWCJQw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWCJQw3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932077AbWCJQw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:52:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:26599 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932073AbWCJQw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:52:27 -0500
Date: Fri, 10 Mar 2006 11:51:57 -0500
From: Dave Jones <davej@redhat.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       sct@redhat.com, jack@suse.cz,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>,
       ext2-devel <Ext2-devel@lists.sourceforge.net>
Subject: Re: [RFC PATCH] ext3 writepage() journal avoidance
Message-ID: <20060310165157.GD18755@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, sct@redhat.com, jack@suse.cz,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>,
	ext2-devel <Ext2-devel@lists.sourceforge.net>
References: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com> <20060309152254.743f4b52.akpm@osdl.org> <1141977557.2876.20.camel@laptopd505.fenrus.org> <20060310002337.489265a3.akpm@osdl.org> <1141980238.2876.27.camel@laptopd505.fenrus.org> <20060310161940.GA18755@redhat.com> <1142008847.21442.17.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142008847.21442.17.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 08:40:47AM -0800, Badari Pulavarty wrote:

 > >  > > I don't know how much usage it's had, sorry.  It's only allowed in
 > >  > > data=writeback mode and not many people seem to use even that.
 > >  > 
 > >  > would you be prepared to turn it on by default in -mm for a bit to see
 > >  > how it holds up? The concept seems valuable in itself, so much so that I
 > >  > feel this should be 1) on always by default when possible and 2) isn't
 > >  > really the kind of thing that should be a long term option; not having
 > >  > it almost is a -o pleaseAddThisBug option for each bug fixed.
 > > 
 > > It'd be good to get that hammered on, as it doesn't see hardly any testing
 > > based upon the experiments I did sometime last year.  It left me with
 > > an unmountable root filesystem :-/
 > 
 > Yuck. You are talking about "nobh" option for writeback mode, correct ?
 > Have any idea on what you were doing ?

Actually, I think I may have neglected to make those mounts writeback.
In retrospect, it was silly, I basically forced nobh on for all mounts.
A few boots later my / reached its maximum mount count, and got a fsck,
which moved a bunch of useful things like /lib/ld-linux.so.2 to lost+found.
There was so much mess that it was easier to reinstall the box than
to pick through it. (Thankfully I tested it on a scratch box ;-)

		Dave
-- 
http://www.codemonkey.org.uk
