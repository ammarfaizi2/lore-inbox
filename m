Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbUKHF2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUKHF2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 00:28:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbUKHF2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 00:28:06 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:14990
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261837AbUKHF1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 00:27:52 -0500
Date: Sun, 7 Nov 2004 21:12:20 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Willy Tarreau <willy@w.ods.org>
Cc: bunk@stusta.de, marcelo.tosatti@cyclades.com, laforge@netfilter.org,
       linux-kernel@vger.kernel.org, chas@cmf.nrl.navy.mil,
       linux-atm-general@lists.sourceforge.net, linux-net@vger.kernel.org
Subject: Re: 2.4.28-rc2: net/atm/proc.c compile error
Message-Id: <20041107211220.053a2a1b.davem@davemloft.net>
In-Reply-To: <20041108051522.GA17729@alpha.home.local>
References: <20041107173753.GB30130@logos.cnet>
	<20041107214246.GY14308@stusta.de>
	<20041107174247.559be214.davem@davemloft.net>
	<20041108051522.GA17729@alpha.home.local>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Nov 2004 06:15:22 +0100
Willy Tarreau <willy@w.ods.org> wrote:

> #define CREATE_ENTRY(name) \
>     name = create_proc_entry(#name,0,atm_proc_root); \
>     if (!name) goto cleanup; \
>     name->data = atm_##name##_info; \
>     name->proc_fops = &proc_spec_atm_operations; \
>     name->owner = THIS_MODULE
> ...
> 623: #if defined(CONFIG_ATM_LANE) || defined(CONFIG_ATM_LANE_MODULE)
> 624:        CREATE_ENTRY(lec);
> 625: #endif
> 
> That's why your grep did not find it ;-)

Indeed, good catch.

> Is it enough to remove these 3 lines ?

No, it isn't, I'll fix this up.
