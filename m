Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261713AbTHZSbt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 14:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262047AbTHZSbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 14:31:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:63122 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261713AbTHZSbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 14:31:47 -0400
Date: Tue, 26 Aug 2003 11:34:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve Lord <lord@sgi.com>
Cc: suparna@in.ibm.com, barryn@pobox.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, linux-xfs@oss.sgi.com
Subject: Re: [BUG] 2.6.0-test4-mm1: NFS+XFS=data corruption
Message-Id: <20030826113429.1440b0d0.akpm@osdl.org>
In-Reply-To: <1061920640.25889.1404.camel@jen.americas.sgi.com>
References: <20030824171318.4acf1182.akpm@osdl.org>
	<20030825193717.GC3562@ip68-4-255-84.oc.oc.cox.net>
	<20030825124543.413187a5.akpm@osdl.org>
	<1061852050.25892.195.camel@jen.americas.sgi.com>
	<20030826031412.72785b15.akpm@osdl.org>
	<20030826110111.GA4750@in.ibm.com>
	<20030826104458.448d1eea.akpm@osdl.org>
	<1061920640.25889.1404.camel@jen.americas.sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord <lord@sgi.com> wrote:
>
>  Does rpm use readv/writev though? Or does the nfs server? not sure
>  how this change would affect the original problem report.

The NFS server uses multisegment writev.  RPM was running at the other end
of the ethernet, so it doesn't really matter what sort of write RPM
is issuing.

