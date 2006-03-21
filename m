Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751777AbWCUUi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbWCUUi4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWCUUi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:38:56 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:19889 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751777AbWCUUiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:38:54 -0500
Date: Tue, 21 Mar 2006 21:36:47 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Jack Steiner <steiner@sgi.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RFC] - Move call to calc_load()
Message-ID: <20060321203647.GA26135@elte.hu>
References: <20060321203249.GA16182@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060321203249.GA16182@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jack Steiner <steiner@sgi.com> wrote:

> Here is the patch that I am proposing. This patch is incomplete 
> because it addresses only the IA64 architecture. If this approach is 
> acceptible, I'll update the patch to cover all architectures.
> 
> 	Signed-off-by: Jack Steiner <steiner@sgi.com>

would be nice to base this on the GTOD patchset - that way you'll only 
have to modify kernel/time/*.c, not a gazillion of architectures...

i agree with your analysis - there is no reason calc_load() should be 
under xtime_lock. I guess no-one noticed this so far because calc_load() 
iterating over hundreds of CPUs isnt too common.

	Ingo
