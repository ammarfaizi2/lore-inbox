Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757015AbWKVUh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757015AbWKVUh1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 15:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757016AbWKVUh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 15:37:27 -0500
Received: from mx0.towertech.it ([213.215.222.73]:17620 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S1757014AbWKVUh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 15:37:26 -0500
Date: Wed, 22 Nov 2006 21:37:24 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [Bulk] Re: [patch 2.6.19-rc6 1/6] rtc class /proc/driver/rtc
 update
Message-ID: <20061122213724.51c3e591@inspiron>
In-Reply-To: <200611201847.58135.david-b@pacbell.net>
References: <200611201014.41980.david-b@pacbell.net>
	<200611201017.19961.david-b@pacbell.net>
	<20061121001352.55f3ce2b@inspiron>
	<200611201847.58135.david-b@pacbell.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 18:47:57 -0800
David Brownell <david-b@pacbell.net> wrote:

> >  I wouldn't change that, the /proc interface to rtc is old
> >  and should not be used anyhow. Here I'm trying to mimic
> >  the behaviour of the original one.
> 
> The "original" one never had such fields.  Even the efirtc.c
> code (which originated those flags) didn't call them that;
> it used "Enabled" not "alrm_enabled", so at least this patch
> moves closer to that "original" behavior.

 [..]

> >  I don't know if there's any user space tool relying on this.
> 
> There shouldn't be any code parsing /proc/driver/rtc ... if there
> is such stuff, it's already got so many variants to cope with that
> adding one that actually matches the rest of the system would be
> a net simplification.

> The whole RTC framework is still labeled "experimental", and
> AFAIK I'm the first person to audit the use of those flags.
> 
> Until it's no longer experimental, I have a hard time thinking
> that backwards compatibility should prevent fixing such interface
> bugs ... interface bugs are normally in the "fix ASAP" category,
> since if you delay fixing them the costs grow exponentially.

 given the experimental status, I'm inclined to remove the /proc
 driver right now.

 Any objection?

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

