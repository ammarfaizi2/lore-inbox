Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWCHC1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWCHC1R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 21:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbWCHC1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 21:27:17 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:938 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932139AbWCHC1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 21:27:16 -0500
Subject: Re: [PATCH] mm: yield during swap prefetching
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, ck@vds.kolivas.org
In-Reply-To: <200603081322.02306.kernel@kolivas.org>
References: <200603081013.44678.kernel@kolivas.org>
	 <200603081312.51058.kernel@kolivas.org> <1141784295.767.126.camel@mindpipe>
	 <200603081322.02306.kernel@kolivas.org>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 21:27:13 -0500
Message-Id: <1141784834.767.134.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 13:22 +1100, Con Kolivas wrote:
> > How is the scheduler supposed to know to penalize a kernel compile
> > taking 100% CPU but not a game using 100% CPU?
> 
> Because being a serious desktop operating system that we are (bwahahahaha) 
> means the user should not have special privileges to run something as simple 
> as a game. Games should not need special scheduling classes. We can always 
> use 'nice' for a compile though. Real time audio is a completely different 
> world to this.  

Actually recent distros like the upcoming Ubuntu Dapper support the new
RLIMIT_NICE and RLIMIT_RTPRIO so this would Just Work without any
special privileges (well, not root anyway - you'd have to put the user
in the right group and add one line to /etc/security/limits.conf).

I think OSX also uses special scheduling classes for stuff with RT
constraints.

The only barrier I see is that games aren't specifically written to take
advantage of RT scheduling because historically it's only been available
to root.

Lee

