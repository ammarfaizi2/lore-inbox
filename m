Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932686AbVKBNK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686AbVKBNK5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVKBNK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:10:57 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:50138 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932686AbVKBNK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:10:57 -0500
Date: Wed, 2 Nov 2005 14:11:00 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, oleg@tv-sign.ru
Subject: Re: [PATCH] Fix SIGSTOP locking issue in -rt
Message-ID: <20051102131100.GA11621@elte.hu>
References: <20051101195857.GA7098@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051101195857.GA7098@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Hello!
> 
> The following patch fixes a locking issue in -rt signals, where the 
> job-control signals drop sighand_lock momentarily during signal 
> handling. This interacts badly with the RCU-ification of unicast 
> signal delivery. The fix is simply to acquire tasklist_lock for 
> job-control signals, since these typically do not have stringent 
> scalability or latency requirements.

thanks, applied - will show up in -rt3.

	Ingo
