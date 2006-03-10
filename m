Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWCJNnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWCJNnm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 08:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWCJNnl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 08:43:41 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:5079 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751095AbWCJNnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 08:43:40 -0500
Subject: Re: [RFC PATCH] ext3 writepage() journal avoidance
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, pbadari@us.ibm.com, sct@redhat.com,
       jack@suse.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net
In-Reply-To: <20060310002337.489265a3.akpm@osdl.org>
References: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com>
	 <20060309152254.743f4b52.akpm@osdl.org>
	 <1141977557.2876.20.camel@laptopd505.fenrus.org>
	 <20060310002337.489265a3.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 07:43:34 -0600
Message-Id: <1141998214.10426.3.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
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

For what it's worth, jfs has been using the nobh_* paths almost since
they where introduced (exclusively, it's not an option), so at least the
vfs pieces have been exercised to some extent.
-- 
David Kleikamp
IBM Linux Technology Center

