Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWHMTMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWHMTMf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 15:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWHMTMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 15:12:35 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5606 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751359AbWHMTMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 15:12:34 -0400
Date: Sun, 13 Aug 2006 12:12:22 -0700
From: Paul Jackson <pj@sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: akpm@osdl.org, kamezawa.hiroyu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: [RFC] ps command race fix
Message-Id: <20060813121222.8210ccc2.pj@sgi.com>
In-Reply-To: <m1zme8v4u9.fsf@ebiederm.dsl.xmission.com>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
	<20060724184847.3ff6be7d.pj@sgi.com>
	<20060725110835.59c13576.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724193318.d57983c1.akpm@osdl.org>
	<20060725115004.a6c668ca.kamezawa.hiroyu@jp.fujitsu.com>
	<20060725121640.246a3720.kamezawa.hiroyu@jp.fujitsu.com>
	<m1mza8wqdc.fsf@ebiederm.dsl.xmission.com>
	<20060813103434.17804d52.akpm@osdl.org>
	<m1zme8v4u9.fsf@ebiederm.dsl.xmission.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> Actually except when we can't find the process we were just at
> the current code doesn't miss any newly added processes. 

Random thought -- could we have file descriptors open on /proc put some
sort of 'hold' on whatever /proc entry they were just at, so it doesn't
disappear out from under them, even if that process has otherwise fully
exited?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
