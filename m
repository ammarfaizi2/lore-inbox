Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261768AbTKNTcv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 14:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbTKNTcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 14:32:51 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:37132
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261768AbTKNTcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 14:32:50 -0500
Date: Fri, 14 Nov 2003 11:32:49 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.0-test9-mm3
Message-ID: <20031114193249.GM2014@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20031112233002.436f5d0c.akpm@osdl.org> <98290000.1068836914@flay> <20031114105947.641335f5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114105947.641335f5.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 10:59:47AM -0800, Andrew Morton wrote:
> "Martin J. Bligh" <mbligh@aracnet.com> wrote:
> >
> > 
> > 
> > > - Several ext2 and ext3 allocator fixes.  These need serious testing on big
> > >   SMP.
> > 
> > OK, ext3 survived a swatting on the 16-way as well>
> 
> Great, thanks.
> 
> > It's still slow as snot, but it does work ;-)
> 
> I think SDET generates storms of metadata updates.  Making the journal
> larger may help get that idle time down.
> 
> Probably the default journal size is too small nowadays.  Most tests seem
> to run faster when it is enlarged.

Or maybe if it didn't start sync committing from the journal once it hits 50%.
