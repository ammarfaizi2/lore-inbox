Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751941AbWCJIoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbWCJIoL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbWCJIoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:44:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:47510 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751941AbWCJIoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:44:07 -0500
Subject: Re: [RFC PATCH] ext3 writepage() journal avoidance
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: pbadari@us.ibm.com, sct@redhat.com, jack@suse.cz,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net
In-Reply-To: <20060310002337.489265a3.akpm@osdl.org>
References: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com>
	 <20060309152254.743f4b52.akpm@osdl.org>
	 <1141977557.2876.20.camel@laptopd505.fenrus.org>
	 <20060310002337.489265a3.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 09:43:57 +0100
Message-Id: <1141980238.2876.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 00:23 -0800, Andrew Morton wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> >
> > 
> > > I'm not sure that PageMappedToDisk() gets set in all the right places
> > > though - it's mainly for the `nobh' handling and block_prepare_write()
> > > would need to be taught to set it.  I guess that'd be a net win, even if
> > > only ext3 uses it..
> > 
> > btw is nobh mature enough yet to become the default, or to just go away
> > entirely as option ?
> 
> I don't know how much usage it's had, sorry.  It's only allowed in
> data=writeback mode and not many people seem to use even that.

would you be prepared to turn it on by default in -mm for a bit to see
how it holds up? The concept seems valuable in itself, so much so that I
feel this should be 1) on always by default when possible and 2) isn't
really the kind of thing that should be a long term option; not having
it almost is a -o pleaseAddThisBug option for each bug fixed.

