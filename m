Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWAZKon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWAZKon (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWAZKon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:44:43 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:10458 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932254AbWAZKom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:44:42 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17368.43029.428875.638790@gargle.gargle.HOWL>
Date: Thu, 26 Jan 2006 13:44:37 +0300
To: Howard Chu <hyc@symas.com>
Cc: Christopher Friesen <cfriesen@nortel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hancockr@shaw.ca
Subject: Re: pthread_mutex_unlock (was Re: sched_yield() makes OpenLDAP slow)
Newsgroups: gmane.linux.kernel
In-Reply-To: <43D7F863.3080207@symas.com>
References: <20060124225919.GC12566@suse.de>
	<20060124232142.GB6174@inferi.kami.home>
	<20060125090240.GA12651@suse.de>
	<20060125121125.GH5465@suse.de>
	<43D78262.2050809@symas.com>
	<43D7BA0F.5010907@nortel.com>
	<43D7C2F0.5020108@symas.com>
	<1138223212.3087.16.camel@mindpipe>
	<43D7F863.3080207@symas.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Howard Chu writes:

[...]

 > 
 > But then we have to deal with you folks' bizarre notion that 
 > sched_yield() can legitimately be a no-op, which also defies the POSIX 
 > spec. Again, in SUSv3 "The /sched_yield/() function shall force the 
 > running thread to relinquish the processor until it again becomes the 
 > head of its thread list. It takes no arguments." There is no language 
 > here saying "sched_yield *may* do nothing at all." There are of course 

As have been pointed to you already, while there is no such language,
the effect may be the same, if --for example-- scheduling policy decides
to put current thread back to "the head of its thread list" immediately
after sched_yield(). Which is a valid behavior for SCHED_OTHER.

Nikita.
