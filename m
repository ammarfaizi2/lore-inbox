Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752175AbWCJI0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbWCJI0M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 03:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWCJI0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 03:26:12 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39092 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752171AbWCJI0L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 03:26:11 -0500
Date: Fri, 10 Mar 2006 00:23:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: pbadari@us.ibm.com, sct@redhat.com, jack@suse.cz,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Ext2-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH] ext3 writepage() journal avoidance
Message-Id: <20060310002337.489265a3.akpm@osdl.org>
In-Reply-To: <1141977557.2876.20.camel@laptopd505.fenrus.org>
References: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com>
	<20060309152254.743f4b52.akpm@osdl.org>
	<1141977557.2876.20.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> wrote:
>
> 
> > I'm not sure that PageMappedToDisk() gets set in all the right places
> > though - it's mainly for the `nobh' handling and block_prepare_write()
> > would need to be taught to set it.  I guess that'd be a net win, even if
> > only ext3 uses it..
> 
> btw is nobh mature enough yet to become the default, or to just go away
> entirely as option ?

I don't know how much usage it's had, sorry.  It's only allowed in
data=writeback mode and not many people seem to use even that.

