Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267210AbTGHLby (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 07:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267226AbTGHLbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 07:31:53 -0400
Received: from ns.suse.de ([213.95.15.193]:530 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267210AbTGHLb0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 07:31:26 -0400
Date: Tue, 8 Jul 2003 13:46:01 +0200
From: Andi Kleen <ak@suse.de>
To: bzzz@tmi.comex.ru
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] parallel directory operations
Message-Id: <20030708134601.7992e64a.ak@suse.de>
In-Reply-To: <87of05ujfo.fsf@gw.home.net>
References: <87wuetukpa.fsf@gw.home.net.suse.lists.linux.kernel>
	<p73brw5qmxk.fsf@oldwotan.suse.de>
	<87of05ujfo.fsf@gw.home.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Jul 2003 15:28:27 +0000
bzzz@tmi.comex.ru wrote:


> dynlocks implements 'lock namespace', so you can lock A for namepace N1 and
> lock B for namespace N1 and so on. we need this because we want to take lock
> on _part_ of directory.

Ok, a mini database lock manager. Wouldn't it be better to use a small hash 
table and lock escalation on overflow for this?  Otherwise you could
have quite a lot of entries queued up in the list if the server is slow.

-Andi
