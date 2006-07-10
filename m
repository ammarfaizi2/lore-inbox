Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161332AbWGJD5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161332AbWGJD5v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 23:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161333AbWGJD5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 23:57:51 -0400
Received: from main.gmane.org ([80.91.229.2]:23704 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161332AbWGJD5u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 23:57:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
Date: Mon, 10 Jul 2006 03:57:21 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <e8sj71$nad$1@sea.gmane.org>
References: <20060627133321.GB3019@elf.ucw.cz> <1152407148.2598.10.camel@coyote.rexursive.com> <200607091551.18456.rjw@sisk.pl> <200607100706.45789.ncunningham@linuxmail.org>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-065-013-029-145.sip.asm.bellsouth.net
User-Agent: slrn/0.9.8.1pl1 (Debian)
Cc: suspend2-devel@lists.suspend2.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ncunningham@linuxmail.org said:
> If Suspend2 added code in a way that broke swsusp, I would agree. But it=20
> doesn't.

That isn't true. I stopped using the suspend2 patches after they broke
the in-kernel suspend twice in the last year, since 2.6.14 or so. (The
first time I reported one of these bugs is here:
http://article.gmane.org/gmane.linux.swsusp.general/3243)

Before I stopped using suspend2, there was a 6-8 month period where I
could easily use both in-kernel swsusp and suspend2 on my laptop. I kept
using suspend2 because it was faster, but I eventually stopped because
it locked up the machine during suspend or crashed it during resume on
one out of every 20-30 tries (and the crashes weren't in some driver
- the backtrace always pointed down into the guts of suspend code).

In-kernel swsusp, on the other hand, aside from being slower, has never
crashed or frozen the machine. The same is true of the new uswsusp code,
which i'd say subjectively feels nearly as fast as suspend2 was, with
both using lzf compression.

Jason

