Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWIZNgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWIZNgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 09:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWIZNgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 09:36:45 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:64511 "EHLO
	amsfep15-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751388AbWIZNgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 09:36:44 -0400
Subject: Re: [PATCH 2/2] serio: lockdep annotation for ps2dev->cmd_mutex
	and serio->lock
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Dave Jones <davej@redhat.com>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0609261520280.3938@twin.jikos.cz>
References: <20060926113150.294656000@chello.nl>
	 <20060926113748.833215000@chello.nl>
	 <Pine.LNX.4.64.0609261520280.3938@twin.jikos.cz>
Content-Type: text/plain
Date: Tue, 26 Sep 2006 15:36:38 +0200
Message-Id: <1159277799.5038.22.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 15:21 +0200, Jiri Kosina wrote:

> the lockdep part of the patch (1/2) is OK. The second part, specifically 
> the libps2.c changes, are not complete - the originally (wrongly) 
> introduced mutex_lock_nested() has to be changed back to mutex_lock(), 
> otherwise we will get spurious warning from lockdep about ps2_mutex_key.

Ah, missed that that part was actually in the tree ;-)

> Below is the fixed version of the patch. I confirm that this (together 
> with Peter's original changes in lockdep, already acked by Ingo) fixes the 
> synpatics passthrough port lockdep warnings.
> 
> So, as long as you, Dmitry, seem to be convenient with this approach, 
> please apply. Thanks.
> 
> Signed-off-by: Jiri Kosina <jikos@jikos.cz>
Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>

Thanks for testing



