Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVKKTMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVKKTMG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 14:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751072AbVKKTMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 14:12:05 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:34709 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751066AbVKKTME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 14:12:04 -0500
Subject: Re: [PATCH] getrusage sucks
From: Lee Revell <rlrevell@joe-job.com>
To: David Wagner <daw-usenet@taverner.CS.Berkeley.EDU>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dl18ro$l0f$1@taverner.CS.Berkeley.EDU>
References: <200511102334.10926.cloud.of.andor@gmail.com>
	 <dl18ro$l0f$1@taverner.CS.Berkeley.EDU>
Content-Type: text/plain
Date: Fri, 11 Nov 2005 14:09:58 -0500
Message-Id: <1131736199.5758.27.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-11 at 05:06 +0000, David Wagner wrote:
> Claudio Scordino  wrote:
> >Does exist any _real_ reason why getrusage can't be invoked by a task to know 
> >statistics of another task ?
> 
> Probably only super-user should be permitted to read the usage information
> about other processes.  Allowing anyone to read anyone else's rusage would
> open up a bunch of side channels that sound pretty dangerous.  For instance,
> user #1 might be able to mount a timing attack against crypto code being
> executed by user #2, and that doesn't sound good.

Why restrict it to root?  Why not just prevent users from reading other
users rusage.  How could it be a security hole for joeuser's process be
able to read the rusage of joeuser's other processes?

Lee

