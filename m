Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWAXVLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWAXVLd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWAXVLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:11:33 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:60288 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750718AbWAXVLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:11:31 -0500
Date: Tue, 24 Jan 2006 22:12:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Joe Korty <joe.korty@ccur.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Define __raw_read_lock etc for uniprocessor builds
Message-ID: <20060124211204.GA23504@elte.hu>
References: <20060124180954.GA14506@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124180954.GA14506@tsunami.ccur.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Joe Korty <joe.korty@ccur.com> wrote:

> Make NOPed versions of __raw_read_lock and family available under 
> uniprocessor kernels.

NACK. The __raw ops are only used by the spinlock implementation, and 
only on SMP.

	Ingo
