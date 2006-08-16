Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750798AbWHPBUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWHPBUj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 21:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWHPBUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 21:20:39 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:25287 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750798AbWHPBUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 21:20:38 -0400
Date: Wed, 16 Aug 2006 10:23:44 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Paul Jackson <pj@sgi.com>
Cc: ebiederm@xmission.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       acahalan@gmail.com
Subject: Re: [RFC] ps command race fix
Message-Id: <20060816102344.b393aee6.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060813121222.8210ccc2.pj@sgi.com>
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
	<20060813121222.8210ccc2.pj@sgi.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Aug 2006 12:12:22 -0700
Paul Jackson <pj@sgi.com> wrote:

> Eric wrote:
> > Actually except when we can't find the process we were just at
> > the current code doesn't miss any newly added processes. 
> 
> Random thought -- could we have file descriptors open on /proc put some
> sort of 'hold' on whatever /proc entry they were just at, so it doesn't
> disappear out from under them, even if that process has otherwise fully
> exited?
> 

Sorry for long absense, I was on vacation.

I and my colleague  are still working on ps command fix.

For holding, I have a patch to insert a token in a list to remember its
position. but my colleague may have another thought.

-Kame

