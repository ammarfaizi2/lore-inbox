Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVAYHXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVAYHXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbVAYHXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:23:42 -0500
Received: from fsmlabs.com ([168.103.115.128]:34538 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261848AbVAYHXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:23:34 -0500
Date: Tue, 25 Jan 2005 00:23:39 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>
Subject: Re: 2.6.11-rc2-mm1 kernel BUG at kernel/workqueue.c:104
In-Reply-To: <20050124214356.6bed35ac.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0501250020320.3010@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0501242144120.3010@montezuma.fsmlabs.com>
 <20050124214356.6bed35ac.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, Andrew Morton wrote:

> I can't reproduce it from a quick test here.  I'd assume that the keystroke
> came in before the vt's workqueue is initialised.  fn_enter() calls
> put_queue() calls con_schedule_flip() calls schedule_work() which goes BUG:

Boot into runlevel 1 (console will then be on serial, nothing on any of 
the VTs), then press a key. This can be any time after it's booted into 
runlevel 1.

Thanks,
	Zwane
