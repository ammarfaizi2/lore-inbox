Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbUKHMXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbUKHMXk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 07:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbUKHMXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 07:23:40 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:65180 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261826AbUKHMWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 07:22:45 -0500
Date: Mon, 8 Nov 2004 18:02:23 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Fix O_SYNC speedup for generic_file_write_nolock
Message-ID: <20041108123223.GA4028@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20041108100738.GA4003@in.ibm.com> <1099908278.3577.2.camel@laptop.fenrus.org> <20041108115353.GA4068@in.ibm.com> <1099915544.3577.9.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099915544.3577.9.camel@laptop.fenrus.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 01:05:44PM +0100, Arjan van de Ven wrote:
> On Mon, 2004-11-08 at 17:23 +0530, Suparna Bhattacharya wrote:
> > On Mon, Nov 08, 2004 at 11:04:38AM +0100, Arjan van de Ven wrote:
> > > > +EXPORT_SYMBOL(sync_page_range_nolock);
> > > 
> > > 
> > > why adding this export? nothing appears to be using it (AIO isn't a module after all)
> > > 
> > 
> > This doesn't have anything to do with AIO. Filesystems which implement 
> > the equivalent of generic_file_write_nolock may use sync_page_range_nolock
> > for O_SYNC.
> > 
> > Does that help clarify ?
> 
> not really; none do so far so how about not adding the export until
> someone does use it ?

It is just like sync_page_range() from akpm's original O_SYNC speedup
patch. Andrew, do we keep or remove the export ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

