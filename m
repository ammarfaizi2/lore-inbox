Return-Path: <linux-kernel-owner+w=401wt.eu-S1426175AbWLHTsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1426175AbWLHTsK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 14:48:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426174AbWLHTsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 14:48:09 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55079 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426172AbWLHTsI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 14:48:08 -0500
Date: Fri, 8 Dec 2006 11:47:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: linux-kernel@vger.kernel.org, balbir@in.ibm.com, csturtiv@sgi.com,
       daw@sgi.com, guillaume.thouvenin@bull.net, jlan@sgi.com,
       nagar@watson.ibm.com, tee@sgi.com
Subject: Re: [patch 01/13] io-accounting: core statistics
Message-Id: <20061208114745.1acd856f.akpm@osdl.org>
In-Reply-To: <457954BF.7040707@cosmosbay.com>
References: <200612081152.kB8BqOkh019750@shell0.pdx.osdl.net>
	<457954BF.7040707@cosmosbay.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec 2006 13:04:15 +0100
Eric Dumazet <dada1@cosmosbay.com> wrote:

> akpm@osdl.org a écrit :
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > The present per-task IO accounting isn't very useful.  It simply counts the
> > number of bytes passed into read() and write().  So if a process reads 1MB
> > from an already-cached file, it is accused of having performed 1MB of I/O,
> > which is wrong.
> 
> Any chance we can report some io accounting values in getresource()/wait4()... 
> too ?

That sounds logical.

> # /usr/bin/time find /usr -name 'foo'
> 0.24user 0.22system 0:00.70elapsed 66%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+222minor)pagefaults 0swaps

But where?  ri_inblock and ru_outblock seem to be count-of-operations, not
number-of-bytes.

