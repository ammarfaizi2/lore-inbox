Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbUKHT31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbUKHT31 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbUKHQt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 11:49:27 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:10625 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S261878AbUKHPWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 10:22:23 -0500
Date: Mon, 8 Nov 2004 07:20:43 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: suparna@in.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Fix O_SYNC speedup for generic_file_write_nolock
Message-ID: <20041108152043.GR12500@ca-server1.us.oracle.com>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	suparna@in.ibm.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
References: <20041108100738.GA4003@in.ibm.com> <1099908278.3577.2.camel@laptop.fenrus.org> <20041108115353.GA4068@in.ibm.com> <1099915544.3577.9.camel@laptop.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099915544.3577.9.camel@laptop.fenrus.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.6+20040907i
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

	OCFS2 uses generic_file_write_nolock(), and as such we might
want to look into this problem and the sync_page_range_nolock() fix.

Joel


-- 

"I always thought the hardest questions were those I could not answer.
 Now I know they are the ones I can never ask."
			- Charlie Watkins

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
