Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270445AbTGWQbW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 12:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270452AbTGWQbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 12:31:22 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:7176 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270445AbTGWQbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 12:31:21 -0400
Subject: Re: [PATCH] O8int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Davide Libenzi <davidel@xmailserver.org>,
       Mike Fedyk <mfedyk@matchmail.com>, Wiktor Wodecki <wodecki@gmx.net>,
       Eugene Teo <eugene.teo@eugeneteo.net>,
       Danek Duvall <duvall@emufarm.org>,
       William Lee Irwin III <wli@holomorphy.com>
In-Reply-To: <200307232155.27107.kernel@kolivas.org>
References: <200307232155.27107.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1058978784.740.4.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 23 Jul 2003 18:46:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-07-23 at 13:55, Con Kolivas wrote:
> Here is an addon to the interactivity work so far. As the ability to become 
> interactive was made much faster and easier in O6*, I was able to remove a lot 
> of extra code uneeded in this latest patch, and remove a lot of the noticable 
> unfairness in the code. This is closer to the original scheduler code after 
> all these patches than any of my previous patches. All of O8int is aimed
> at fixing unfairness in my interactivity patches.

Testing it right now on top of 2.6.0-test1-mm2 :-)

Overall it feels better. I can't make XMMS skip at all. Under low load,
X is very smooth, but X is still jerky/jumpy when the system is under
heavy load (while true; do a=2; done) and I start moving windows all
around my KDE desktop. Renicing the X server to -20 makes it very smooth
under load (yeah, I know I shouldn't do this).

I'm playing a bit with tunables to see if I can tune the scheduler a
little bit for my system/workload. I've had good results reducing max
timeslice to 100 (yeah, I know I shouldn't do this too).

Will keep you informed :-)

