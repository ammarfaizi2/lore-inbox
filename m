Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWAYVGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWAYVGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 16:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWAYVGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 16:06:53 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:8428 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751212AbWAYVGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 16:06:52 -0500
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP
	slow)
From: Lee Revell <rlrevell@joe-job.com>
To: Howard Chu <hyc@symas.com>
Cc: Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
In-Reply-To: <43D7C2F0.5020108@symas.com>
References: <20060124225919.GC12566@suse.de>
	 <20060124232142.GB6174@inferi.kami.home> <20060125090240.GA12651@suse.de>
	 <20060125121125.GH5465@suse.de> <43D78262.2050809@symas.com>
	 <43D7BA0F.5010907@nortel.com>  <43D7C2F0.5020108@symas.com>
Content-Type: text/plain
Date: Wed, 25 Jan 2006 16:06:51 -0500
Message-Id: <1138223212.3087.16.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-25 at 10:26 -0800, Howard Chu wrote:
> The SUSv3 text seems pretty clear. It says "WHEN
> pthread_mutex_unlock() 
> is called, ... the scheduling policy SHALL decide ..." It doesn't say 
> MAY, and it doesn't say "some undefined time after the call."  

This does NOT require pthread_mutex_unlock() to cause the scheduler to
immediately pick a new runnable process.  It only says it's up the the
scheduling POLICY what to do.  The policy could be "let the unlocking
thread finish its timeslice then reschedule".

Lee

