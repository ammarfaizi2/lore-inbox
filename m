Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbTISRjl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 13:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbTISRjl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 13:39:41 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:45963 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261647AbTISRjk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 13:39:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: use O_DIRECT open file, when read will hang.
Date: Fri, 19 Sep 2003 10:38:34 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, suparna@in.ibm.com
References: <20030919124631.3b4e6301.hugang@soulinfo.com> <200309190939.18796.pbadari@us.ibm.com> <20030919095736.284aaa9f.akpm@osdl.org>
In-Reply-To: <20030919095736.284aaa9f.akpm@osdl.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200309191038.34117.pbadari@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 September 2003 09:57 am, Andrew Morton wrote:
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> > I am also seeing some kind of regression on raw in 2.6.0-test5-mm2.
>
> What is "some kind of regression"?

I am getting different errors with database: ( I don't see these with my
"dd" tests)

	(1) sometimes open fails with EFAULT 
	(2) sometimes read/write fails with EFAULT

I have been running on "raw" for quite a while, i haven't seen this before.
I moved my logdevice to filesystem files, everything is fine.

>
> > Unfortunately, this happens only with huge database benchmarks.
> > I still haven't narrowed it down.
>
> Use mm3 - it has fixes.  Daniel McNeil reports that mm3 fixes the dbt2
> problems he was seeing.

Okay. I will use -mm3.

Thanks,
Badari
