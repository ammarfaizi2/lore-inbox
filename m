Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbTGHL5D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265142AbTGHL5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:57:03 -0400
Received: from ns.suse.de ([213.95.15.193]:57099 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265141AbTGHL5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:57:01 -0400
Date: Tue, 8 Jul 2003 14:11:36 +0200
From: Andi Kleen <ak@suse.de>
To: bzzz@tmi.comex.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] parallel directory operations
Message-Id: <20030708141136.18e0034f.ak@suse.de>
In-Reply-To: <87fzlhuif0.fsf@gw.home.net>
References: <87wuetukpa.fsf@gw.home.net.suse.lists.linux.kernel>
	<p73brw5qmxk.fsf@oldwotan.suse.de>
	<87of05ujfo.fsf@gw.home.net>
	<20030708134601.7992e64a.ak@suse.de>
	<87fzlhuif0.fsf@gw.home.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jul 2003 15:50:27 +0000
bzzz@tmi.comex.ru wrote:

> well, it makes sense. AFAIU, only problem with this solution is that we need
> very well-tuned hash function.

A small rbtree or similar would work too. Linux already has the utility code for this.
And a fast path to avoid the overhead when it isn't needed (e.g. first locker uses a 
preallocated lock node, which is cheap to queue)


-Andi
