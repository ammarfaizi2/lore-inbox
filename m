Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932417AbVHaHTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVHaHTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVHaHTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:19:43 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:46738 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932417AbVHaHTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:19:42 -0400
Date: Wed, 31 Aug 2005 09:20:17 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org
Subject: Re: [PATCH] PREEMPT_RT vermagic
Message-ID: <20050831072017.GA7125@elte.hu>
References: <20050829084829.GA23176@elte.hu> <1125441737.18150.43.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125441737.18150.43.camel@dhcp153.mvista.com>
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

> Ingo,
> 	This patch adds a vermagic hook so PREEMPT_RT modules can be
> distinguished from PREEMPT_DESKTOP modules.

vermagic is very crude and there are zillions of other details and 
.config flags that might make a module incompatible. You can use 
CONFIG_MODVERSIONS to get a stronger protection that vermagic, but 
that's far from perfect too. The right solution is the module signing 
framework in Fedora. Until that gets merged upstream just dont mix 
incompatible modules, and keep things tightly packaged.

	Ingo
