Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVIZGZF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVIZGZF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 02:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932408AbVIZGZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 02:25:05 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:13728 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932406AbVIZGZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 02:25:01 -0400
Date: Mon, 26 Sep 2005 08:25:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RT: Checks for cmpxchg in get_task_struct_rcu()
Message-ID: <20050926062552.GD3273@elte.hu>
References: <1127345874.19506.43.camel@dhcp153.mvista.com> <433201FC.8040004@yahoo.com.au> <1127355538.8950.1.camel@c-67-188-6-232.hsd1.ca.comcast.net> <1127364629.8950.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127364629.8950.6.camel@c-67-188-6-232.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> Checks for cmpxchg in get_task_struct_rcu() . No race version.

shouldnt we actually define a global, default cmpxchg() function, based 
on IRQ-disable - instead of open-coding one?

	Ingo
