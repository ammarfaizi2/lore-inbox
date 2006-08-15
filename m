Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752078AbWHOCHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbWHOCHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 22:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWHOCHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 22:07:33 -0400
Received: from alnrmhc12.comcast.net ([206.18.177.52]:20416 "EHLO
	alnrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751456AbWHOCHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 22:07:31 -0400
Subject: Re: Kernel patches enabling better POSIX AIO (Was Re: [3/4]
	kevent: AIO, aio_sendfile)
From: Nicholas Miell <nmiell@comcast.net>
To: Ulrich Drepper <drepper@redhat.com>
Cc: suparna@in.ibm.com, sebastien.dugue@bull.net,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>, linux-aio@kvack.org, mingo@elte.hu
In-Reply-To: <44E0A6F6.509@redhat.com>
References: <1153982954.3887.9.camel@frecb000686>
	 <44C8DB80.6030007@us.ibm.com> <44C9029A.4090705@oracle.com>
	 <1154024943.29920.3.camel@dyn9047017100.beaverton.ibm.com>
	 <44C90987.1040200@redhat.com>
	 <1154034164.29920.22.camel@dyn9047017100.beaverton.ibm.com>
	 <1154091500.13577.14.camel@frecb000686> <44DCDE73.9030901@redhat.com>
	 <20060812182928.GA1989@in.ibm.com> <44DE27AB.7040507@redhat.com>
	 <20060814070210.GA27005@in.ibm.com>  <44E0A6F6.509@redhat.com>
Content-Type: text/plain
Date: Mon, 14 Aug 2006 19:06:56 -0700
Message-Id: <1155607616.2468.1.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-14 at 09:38 -0700, Ulrich Drepper wrote:
> Suparna Bhattacharya wrote:
> > Is there a (remote) possibility that the thread could have died and its
> > pid got reused by a new thread in another process ? Or is there a mechanism
> > that prevents such a possibility from arising (not just in NPTL library,
> > but at the kernel level) ?
> 
> The UID/GID won't help you with dying processes.  What if the same user
> creates a process with the same PID?  That process will not expect the
> notification and mustn't receive it.  If you cannot detect whether the
> issuing process died you have problems which cannot be solved with a
> uid/gid pair.
> 
> 

Eric W. Biederman sent a series of patches that introduced a struct
task_ref specifically to solve this sort of problem on January 28 of
this year, but I don't think it went anywhere.


-- 
Nicholas Miell <nmiell@comcast.net>

