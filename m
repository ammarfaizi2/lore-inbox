Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275091AbTHLHlC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 03:41:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275093AbTHLHlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 03:41:02 -0400
Received: from mail14.speakeasy.net ([216.254.0.214]:20161 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S275091AbTHLHlA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 03:41:00 -0400
Date: Tue, 12 Aug 2003 00:40:52 -0700
Message-Id: <200308120740.h7C7eqV20032@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Matt Wilson <msw@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] zap_other_threads() detaches thread group leader
In-Reply-To: Matt Wilson's message of  Saturday, 9 August 2003 15:17:48 -0400 <20030809151748.B26520@devserv.devel.redhat.com>
X-Shopping-List: (1) Pneumatic honey
   (2) Latent pajamas
   (3) Paradoxical circumcisions
   (4) Reluctant melon Johnny Carson lookalikes
   (5) Caustic deriders
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because of other sticky issues still unresolved and the lack of apparent
real need to support the troublesome case, at last check Linus was leaning
towards disallowing CLONE_THREAD&~CLONE_DETACHED in copy_process so that
the exit_signal = -1 change in zap_other_threads is no longer apropos and
can be taken back out entirely.  Unless that is done, the != group_leader
check most certainly has to go in.



Thanks,
Roland
