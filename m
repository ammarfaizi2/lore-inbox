Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274977AbTHPXRg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 19:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274980AbTHPXRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 19:17:35 -0400
Received: from www.wireboard.com ([216.151.155.101]:58017 "EHLO
	varsoon.wireboard.com") by vger.kernel.org with ESMTP
	id S274977AbTHPXRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 19:17:35 -0400
To: "David D. Hagood" <wowbagger@sktc.net>
Cc: Valdis.Kletnieks@vt.edu, Michael Frank <mhf@linuxmail.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dumb question: Why are exceptions such as SIGSEGV not logged
References: <200308170410.30844.mhf@linuxmail.org>
	<200308162049.h7GKnwnP024716@turing-police.cc.vt.edu>
	<3F3EB8FA.1080605@sktc.net>
From: Doug McNaught <doug@mcnaught.org>
Date: 16 Aug 2003 19:17:29 -0400
In-Reply-To: "David D. Hagood"'s message of "Sat, 16 Aug 2003 18:06:34 -0500"
Message-ID: <m3oeypb3au.fsf@varsoon.wireboard.com>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David D. Hagood" <wowbagger@sktc.net> writes:

> Valdis.Kletnieks@vt.edu wrote:
> 
> > Consider this code:
> > 	char *foo = 0;
> > 	sigset(SIGSEGV,SIG_IGNORE);
> > 	for(;;) { *foo = '\5'; }
> > Your logfiles just got DoS'ed....
> 
> 
> Why not then just log uncaught exceptions?

You can still DoS by forking repeatedly and having the child die with
SEGV...

-Doug
