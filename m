Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbTFBTPF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 15:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTFBTPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 15:15:05 -0400
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:27312 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261820AbTFBTPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 15:15:04 -0400
Subject: Re: Strange load issues with 2.5.69/70 in both -mm and -bk trees.
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306021927170.10228-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0306021927170.10228-100000@localhost.localdomain>
Content-Type: text/plain
Organization: 
Message-Id: <1054582030.4679.15.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Jun 2003 15:27:11 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-3.8, required 10,
	AWL, EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, SPAM_PHRASE_01_02)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-02 at 13:28, Ingo Molnar wrote:
> to prove this point, could you try and renice wineserver to -10 (as root) 
> - does that fix the latency issues still?
> 
> (if this doesnt then it could be the foreground process starving yet
> another process - we have to find out which one.)

Yes, I thought the same thing, and I did just that, but no, it doesn't
fix the latency issue.  This system has very little running, I made sure
that there were no sound servers such as esd or arts running, nothing. 
Basically, a plain KDE (with artsd disabled), mozilla, and Crossover
wine plugin.  Even though I couldn't see how it would affect anything I
tried bumping up the priorities of other processes such as mozilla
itself, X, etc.  Nothing fixed the problem except for lowering the
priority of the wine process.

Could this process be starving the kernel itself so that it simply
doesn't have time to service the sound correctly?

Later,
Tom




