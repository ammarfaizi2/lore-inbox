Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbTIKUQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbTIKUQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:16:57 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53510 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261494AbTIKUQ4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:16:56 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: 11 Sep 2003 20:08:01 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjqkn1$tbq$1@gatekeeper.tmr.com>
References: <3F6087FC.7090508@pobox.com> <20030911165826.06f2fd16.ak@suse.de>
X-Trace: gatekeeper.tmr.com 1063310881 30074 192.168.12.62 (11 Sep 2003 20:08:01 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030911165826.06f2fd16.ak@suse.de>,
Andi Kleen  <ak@suse.de> wrote:

| If you really want to save text space just use .bz2 compression 
| or compile the kernel with -Os. There are also other subsystems
| that would benefit much more (better effort/cost ratio) than adding
| micro #ifdefs to core code.

Good idea, let's put stuff like this in hardware-dependent includes, and
just have a single line in the core code  like
  check_special_pfault_cases;
and that documents what is happening as well as avoiding reading around
it. It seems silly to leave a big hunk of code in when developers are
making efforts to drop cruft and keep Linux practical for embedded
systems.

People were willing to drop the whole prefetch feature, I don't see that
micro ifdefs are a bad thing, it's just that thought needs to go into
making the code readable.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
