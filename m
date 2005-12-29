Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbVL2ItR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVL2ItR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbVL2ItR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:49:17 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:53942 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965062AbVL2ItQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:49:16 -0500
Date: Thu, 29 Dec 2005 09:48:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-tiny@selenic.com
Subject: Re: [PATCH] Make sysenter support optional
Message-ID: <20051229084858.GA31412@elte.hu>
References: <20051228212402.GX3356@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051228212402.GX3356@waste.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.9 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.9 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matt Mackall <mpm@selenic.com> wrote:

> This adds configurable sysenter support on x86. This saves about 5k on 
> small systems.

note that this also turns off vsyscalls. Right now vsyscalls are mostly 
about sysenter support, but that's not fundamentally so. 4k of the 5k 
savings come from the turn-off-vsyscalls portion.

	Ingo
