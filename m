Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1425467AbWLHMHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425467AbWLHMHn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 07:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425446AbWLHMHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 07:07:30 -0500
Received: from sp604002mt.neufgp.fr ([84.96.92.61]:61081 "EHLO sMtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1425461AbWLHMHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 07:07:17 -0500
Date: Fri, 08 Dec 2006 13:04:15 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [patch 01/13] io-accounting: core statistics
In-reply-to: <200612081152.kB8BqOkh019750@shell0.pdx.osdl.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, balbir@in.ibm.com, csturtiv@sgi.com,
       daw@sgi.com, guillaume.thouvenin@bull.net, jlan@sgi.com,
       nagar@watson.ibm.com, tee@sgi.com
Message-id: <457954BF.7040707@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <200612081152.kB8BqOkh019750@shell0.pdx.osdl.net>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akpm@osdl.org a écrit :
> From: Andrew Morton <akpm@osdl.org>
> 
> The present per-task IO accounting isn't very useful.  It simply counts the
> number of bytes passed into read() and write().  So if a process reads 1MB
> from an already-cached file, it is accused of having performed 1MB of I/O,
> which is wrong.

Any chance we can report some io accounting values in getresource()/wait4()... 
too ?

# /usr/bin/time find /usr -name 'foo'
0.24user 0.22system 0:00.70elapsed 66%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+222minor)pagefaults 0swaps

