Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWCJQUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWCJQUn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWCJQUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:20:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8905 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750744AbWCJQUm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:20:42 -0500
Date: Fri, 10 Mar 2006 11:19:40 -0500
From: Dave Jones <davej@redhat.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, pbadari@us.ibm.com, sct@redhat.com,
       jack@suse.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH] ext3 writepage() journal avoidance
Message-ID: <20060310161940.GA18755@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Andrew Morton <akpm@osdl.org>, pbadari@us.ibm.com, sct@redhat.com,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net
References: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com> <20060309152254.743f4b52.akpm@osdl.org> <1141977557.2876.20.camel@laptopd505.fenrus.org> <20060310002337.489265a3.akpm@osdl.org> <1141980238.2876.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141980238.2876.27.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 09:43:57AM +0100, Arjan van de Ven wrote:
 > On Fri, 2006-03-10 at 00:23 -0800, Andrew Morton wrote:
 > > Arjan van de Ven <arjan@infradead.org> wrote:
 > > >
 > > > 
 > > > > I'm not sure that PageMappedToDisk() gets set in all the right places
 > > > > though - it's mainly for the `nobh' handling and block_prepare_write()
 > > > > would need to be taught to set it.  I guess that'd be a net win, even if
 > > > > only ext3 uses it..
 > > > 
 > > > btw is nobh mature enough yet to become the default, or to just go away
 > > > entirely as option ?
 > > 
 > > I don't know how much usage it's had, sorry.  It's only allowed in
 > > data=writeback mode and not many people seem to use even that.
 > 
 > would you be prepared to turn it on by default in -mm for a bit to see
 > how it holds up? The concept seems valuable in itself, so much so that I
 > feel this should be 1) on always by default when possible and 2) isn't
 > really the kind of thing that should be a long term option; not having
 > it almost is a -o pleaseAddThisBug option for each bug fixed.

It'd be good to get that hammered on, as it doesn't see hardly any testing
based upon the experiments I did sometime last year.  It left me with
an unmountable root filesystem :-/

		Dave

-- 
http://www.codemonkey.org.uk
