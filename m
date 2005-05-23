Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVEWQkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVEWQkf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 12:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261912AbVEWQkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 12:40:35 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:28043 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261910AbVEWQka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 12:40:30 -0400
Message-ID: <42920958.B67C742F@tv-sign.ru>
Date: Mon, 23 May 2005 20:48:24 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-06
References: <Pine.LNX.4.44.0505230800580.863-100000@dhcp153.mvista.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another problem in plist_add:

> existing_sp_head:
> 	itr_pl2 = container_of(itr_pl->dp_node.prev, struct plist, dp_node);
> 	list_add(&pl->sp_node, &itr_pl2->sp_node);

This breaks fifo ordering.

Oleg.
