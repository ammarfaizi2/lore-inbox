Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751005AbWERHzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751005AbWERHzy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWERHzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:55:54 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:57054 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751005AbWERHzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:55:52 -0400
Date: Thu, 18 May 2006 09:55:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] scheduling while atomic in fs/file.c
Message-ID: <20060518075548.GA30387@elte.hu>
References: <200605161628.k4GGSID1004173@dwalker1.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605161628.k4GGSID1004173@dwalker1.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> Quite the smp_processor_id() warnings. The timer was pinned before, 
> but the spinlock protection is such that the timer can migrate with 
> out issues. Allowing the timers to migrate (although not often) will 
> allow them to move off busy cpu's , and potentially follow the work 
> queue that they wake up.

thanks, applied.

	Ingo
