Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269125AbUIXUjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269125AbUIXUjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 16:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269135AbUIXUjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 16:39:48 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:5022 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269125AbUIXUjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 16:39:00 -0400
Subject: Re: mlock(1)
From: Lee Revell <rlrevell@joe-job.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Neil Horman <nhorman@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <41548493.3000905@pobox.com>
References: <41547C16.4070301@pobox.com>  <4154805D.8030904@redhat.com>
	 <1096057867.11589.19.camel@krustophenia.net>  <41548493.3000905@pobox.com>
Content-Type: text/plain
Message-Id: <1096058339.11589.27.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 24 Sep 2004 16:39:00 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-24 at 16:33, Jeff Garzik wrote:
> Lee Revell wrote:
> > Is this really a good idea?  I suspect it would be abused.  For example,
> > people would mlock mozilla or openoffice to keep it from being paged out
> > overnight when updatedb runs, where the real solution is to fix the
> > problem with the VM that causes updatedb to force other apps to swap
> > out. 
> 
> Use /proc/swappiness for this
> 
> It definitely helped for me.  I set it really low, around '10' or so.
> 

Yeah, this never bugged me much but some people hate this behavior.  I
set it to 0, works fine.

My point is that people will abuse mlock(1).  Maybe that is not our
concern.  But, the current users of mlock have to know what they are
doing to some extent.  Like the ntpd example, it doesn't mlock ALL it's
memory, just the portion that can't be swapped out due to realtime
constraints.

Lee

