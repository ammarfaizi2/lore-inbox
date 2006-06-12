Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751913AbWFLMXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbWFLMXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWFLMXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:23:36 -0400
Received: from vbn.0050556.lodgenet.net ([216.142.194.234]:21930 "EHLO
	vbn.0050556.lodgenet.net") by vger.kernel.org with ESMTP
	id S1751910AbWFLMXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:23:35 -0400
Subject: Re: NPTL mutex and the scheduling priority
From: Arjan van de Ven <arjan@infradead.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060612.171035.108739746.nemoto@toshiba-tops.co.jp>
References: <20060612.171035.108739746.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 14:23:28 +0200
Message-Id: <1150115008.3131.106.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 17:10 +0900, Atsushi Nemoto wrote:
> # This is a copy of message posted libc-alpha ML.  I want to hear from
> # kernel people too ...
> 
> Hi.  I found that it seems NPTL's mutex does not follow the scheduling
> parameter.  If some threads were blocked by getting a single
> mutex_lock, I expect that a thread with highest priority got the lock
> first, but current NPTL's behaviour is different.
\

you want to use the PI futexes that are in 2.6.17-rc5-mm tree

