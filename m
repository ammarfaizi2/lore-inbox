Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUEDSze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUEDSze (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 14:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbUEDSze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 14:55:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:10671 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264579AbUEDSzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 14:55:32 -0400
Date: Tue, 4 May 2004 11:55:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jose R. Santos" <jrsantos@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, anton@samba.org, dheger@us.ibm.com
Subject: Re: [PATCH] dentry and inode cache hash algorithm performance
 changes.
Message-Id: <20040504115510.696184dc.akpm@osdl.org>
In-Reply-To: <20040504131223.GA28009@austin.ibm.com>
References: <20040430191539.GC14271@rx8.ibm.com>
	<20040430131832.45be6956.akpm@osdl.org>
	<20040430205701.GG14271@rx8.ibm.com>
	<20040430213324.GK14271@rx8.ibm.com>
	<20040430150256.25735762.akpm@osdl.org>
	<20040504131223.GA28009@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jose R. Santos" <jrsantos@austin.ibm.com> wrote:
>
> * Andrew Morton <akpm@osdl.org> [2004-04-30 15:02:56 -0700]:
> > Also, I'd be interested in understanding what the input to the hashing
> > functions looked like in this testing.  It could be that the new hash just
> > happens to work well with one particular test's dataset.  Please convince
> > us otherwise ;)
> 
> Andrew - Is there any workload you want me to run to show that this hash
> function is going to be equal or better that the one already provided
> in Linux?

Not really - it sounds like you've covered it pretty well.  Did you try SDET?

It could be that reducing the hash table size will turn pretty much any
workload into a test of the hash quality.

