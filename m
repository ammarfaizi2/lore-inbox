Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWE3Jl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWE3Jl6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 05:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWE3Jl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 05:41:58 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:49800 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932210AbWE3Jl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 05:41:58 -0400
Date: Tue, 30 May 2006 11:42:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060530094219.GB27839@elte.hu>
References: <20060530022925.8a67b613.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060530022925.8a67b613.akpm@osdl.org>
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


* Andrew Morton <akpm@osdl.org> wrote:

> - Merged the runtime locking validator.  If you enable this your 
>   machine will run slowly.

if you disable CONFIG_DEBUG_LOCKDEP it should be quite OK. (If debugging 
is disabled then the lockless "chain cache" is fully utilized and we 
should rarely go into the more complex portions of kernel/lockdep.c.)

	Ingo
