Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310160AbSCFUVw>; Wed, 6 Mar 2002 15:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310157AbSCFUVl>; Wed, 6 Mar 2002 15:21:41 -0500
Received: from ns01.netrox.net ([64.118.231.130]:21169 "EHLO smtp01.netrox.net")
	by vger.kernel.org with ESMTP id <S310160AbSCFUV2>;
	Wed, 6 Mar 2002 15:21:28 -0500
Subject: Re: [PATCH] 2.5: preemptive kernel on UP
From: Robert Love <rml@tech9.net>
To: george anzinger <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C866B56.AE2F63BD@mvista.com>
In-Reply-To: <1015287099.865.3.camel@phantasy> 
	<3C866B56.AE2F63BD@mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 06 Mar 2002 15:21:20 -0500
Message-Id: <1015446092.1482.6.camel@icbm>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-03-06 at 14:17, george anzinger wrote:

> With out a lot of looking, wouldn't it be easier to just change fork?

Don't we need to unlock the rq regardless of what fork does?

Also, the alternative would be to set preempt_count to 0 if
CONFIG_PREEMPT and 1 if CONFIG_PREEMPT && CONFIG_SMP.  I figured Linus
would balk at that sort #if/#else in do_fork.  And, even then, is it
safe to start the task with a preempt_count of 0?

	Robert Love

