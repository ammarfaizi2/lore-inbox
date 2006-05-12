Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWELGcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWELGcg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 02:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWELGcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 02:32:36 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:52392 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751000AbWELGcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 02:32:36 -0400
Date: Fri, 12 May 2006 08:32:20 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: =?iso-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>,
       linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [RFC][PATCH RT 1/2] futex_requeue-optimize
Message-ID: <20060512063220.GA630@elte.hu>
References: <20060510112701.7ea3a749@frecb000686> <20060511091541.05160b2c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060511091541.05160b2c.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.3
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.3 required=5.9 tests=ALL_TRUSTED,AWL,SUBJ_HAS_UNIQ_ID autolearn=no SpamAssassin version=3.0.3
	1.1 SUBJ_HAS_UNIQ_ID       Subject contains a unique ID
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	-0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> Should the futex code be using hlist_heads for that hashtable?

yeah. That would save 1K of .data on 32-bit platforms, 2K on 64-bit 
platforms.

	Ingo
