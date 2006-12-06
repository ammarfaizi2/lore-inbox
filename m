Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760615AbWLFN4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760615AbWLFN4M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 08:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760620AbWLFN4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 08:56:12 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:37016 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760615AbWLFN4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 08:56:10 -0500
Date: Wed, 6 Dec 2006 14:54:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Cc: Andrew Morton <akpm@osdl.org>, Jiri Kosina <jkosina@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] let WARN_ON() output the condition
Message-ID: <20061206135445.GA17224@elte.hu>
References: <20061205172737.14ecfeb3.akpm@osdl.org> <200612061252.kB6CqRYP008046@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612061252.kB6CqRYP008046@laptop13.inf.utfsm.cl>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -3.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_40 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-1.1 BAYES_40               BODY: Bayesian spam probability is 20 to 40%
	[score: 0.3906]
	0.6 AWL                    AWL: From: address is in the auto white-list
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:

> Why not just:
> 
>     WARN_ON(debug_locks_off())
> 
> here? Would give a more readable message too, IMHO.

debug_locks_off() has a side-effect, and in general we dont like to put 
stuff with side-effects witin WARN_ON().

	Ingo
