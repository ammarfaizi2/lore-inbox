Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbTHZR6o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261713AbTHZR6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:58:44 -0400
Received: from tolkor.sgi.com ([198.149.18.6]:51929 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S261413AbTHZR5j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:57:39 -0400
Subject: Re: [BUG] 2.6.0-test4-mm1: NFS+XFS=data corruption
From: Steve Lord <lord@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: suparna@in.ibm.com, barryn@pobox.com,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
       linux-xfs@oss.sgi.com
In-Reply-To: <20030826104458.448d1eea.akpm@osdl.org>
References: <20030824171318.4acf1182.akpm@osdl.org>
	 <20030825193717.GC3562@ip68-4-255-84.oc.oc.cox.net>
	 <20030825124543.413187a5.akpm@osdl.org>
	 <1061852050.25892.195.camel@jen.americas.sgi.com>
	 <20030826031412.72785b15.akpm@osdl.org> <20030826110111.GA4750@in.ibm.com>
	 <20030826104458.448d1eea.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1061920640.25889.1404.camel@jen.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 Aug 2003 12:57:21 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 12:44, Andrew Morton wrote:
> Suparna Bhattacharya <suparna@in.ibm.com> wrote:
> >
> >  > Binary searching reveals that the offending patch is
> >  > O_SYNC-speedup-nolock-fix.patch
> >  > 
> > 
> >  I'm not sure if this would help here, but there is
> >  one bug which I just spotted which would affect writev from
> >  XFS. I wasn't passing the nr_segs down properly.
> 
> That fixes it, thanks.

Does rpm use readv/writev though? Or does the nfs server? not sure
how this change would affect the original problem report.

Steve

-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com
