Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTEVUh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 16:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTEVUh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 16:37:59 -0400
Received: from holomorphy.com ([66.224.33.161]:45198 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263258AbTEVUh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 16:37:58 -0400
Date: Thu, 22 May 2003 13:50:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: jjs <jjs@tmsusa.com>
Cc: Andrew Morton <akpm@digeo.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-mm8 improvements and one oops
Message-ID: <20030522205051.GX8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	jjs <jjs@tmsusa.com>, Andrew Morton <akpm@digeo.com>,
	linux kernel <linux-kernel@vger.kernel.org>
References: <3ECD13A1.9060103@tmsusa.com> <20030522130731.10f34d58.akpm@digeo.com> <3ECD35E2.10109@tmsusa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ECD35E2.10109@tmsusa.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote
>> You hit the free-of-a-freed-task_struct bug.
>> This bug has been hanging around for ages.  It is very rare and nobody
>> knows what causes it.

On Thu, May 22, 2003 at 01:41:06PM -0700, jjs wrote:
> I'm lucky I suppose -

The cause for this is less than obvious.


Andrew Morton wrote
>> Are you running preempt?  SMP?   Is it repeatable?

On Thu, May 22, 2003 at 01:41:06PM -0700, jjs wrote:
> It's preempt, defintely, always -
> But just a UP kernel on a lowly UP box -
> As for repeatability, I'll see if I can induce
> the oops again but there's no telling...

Preempt is a common theme in the reports I've seen on this. It appears
SMP allows the offender to clean up after the bug, but relatively long
times between racy things rescheduling on preempt triggers the issue
more readily.


-- wli
