Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTDXNBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 09:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbTDXNBG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 09:01:06 -0400
Received: from to-telus.redhat.com ([207.219.125.105]:53755 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id S261868AbTDXNBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 09:01:04 -0400
Date: Thu, 24 Apr 2003 09:13:12 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Filesystem AIO read-write patches
Message-ID: <20030424091312.E9036@redhat.com>
References: <20030424102221.A2166@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424102221.A2166@in.ibm.com>; from suparna@in.ibm.com on Thu, Apr 24, 2003 at 10:22:22AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 24, 2003 at 10:22:22AM +0530, Suparna Bhattacharya wrote:
> The task->io_wait field reflects the wait context in which
> a task is executing its i/o operations. For synchronous i/o
> task->io_wait is NULL, and the wait context is local on
> stack; for threads doing io submits or retries on behalf 
> of async i/o callers, tsk->io_wait is the wait queue 
> function entry to be notified on completion of a condition 
> required for i/o to progress. 

This is seriously wrong.  Changing the behaviour of functions to depend on 
a hidden parameter is bound to lead to coding errors.  It is far better to 
make the parameter explicite rather than implicite.

		-ben
