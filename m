Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbWH0XjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbWH0XjB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 19:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWH0XjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:39:01 -0400
Received: from ozlabs.org ([203.10.76.45]:20386 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750787AbWH0Xi7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:38:59 -0400
Subject: Re: Is stopmachine() preempt safe?
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <10990.1156671752@ocs10w.ocs.com.au>
References: <10990.1156671752@ocs10w.ocs.com.au>
Content-Type: text/plain
Date: Mon, 28 Aug 2006 09:38:55 +1000
Message-Id: <1156721935.10467.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-08-27 at 19:42 +1000, Keith Owens wrote:
> I cannot convince myself that stopmachine() is preempt safe.  What
> prevents this race with CONFIG_PREEMPT=y?

Nothing.  Read side is preempt_disable.  Write side is stopmachine.

I wrote it that way to avoid having to touch the scheduler.  A bigger
stopmachine is possible which schedules all preempted tasks; my plan is
to write such a thing shortly, to see what it looks like.

Cheers,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

