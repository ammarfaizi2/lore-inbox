Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbTHZRmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262823AbTHZRmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:42:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:55009 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261811AbTHZRmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:42:18 -0400
Date: Tue, 26 Aug 2003 10:44:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: suparna@in.ibm.com
Cc: lord@sgi.com, barryn@pobox.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-xfs@oss.sgi.com
Subject: Re: [BUG] 2.6.0-test4-mm1: NFS+XFS=data corruption
Message-Id: <20030826104458.448d1eea.akpm@osdl.org>
In-Reply-To: <20030826110111.GA4750@in.ibm.com>
References: <20030824171318.4acf1182.akpm@osdl.org>
	<20030825193717.GC3562@ip68-4-255-84.oc.oc.cox.net>
	<20030825124543.413187a5.akpm@osdl.org>
	<1061852050.25892.195.camel@jen.americas.sgi.com>
	<20030826031412.72785b15.akpm@osdl.org>
	<20030826110111.GA4750@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>
>  > Binary searching reveals that the offending patch is
>  > O_SYNC-speedup-nolock-fix.patch
>  > 
> 
>  I'm not sure if this would help here, but there is
>  one bug which I just spotted which would affect writev from
>  XFS. I wasn't passing the nr_segs down properly.

That fixes it, thanks.
