Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031337AbWLANAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031337AbWLANAA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031336AbWLANAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:00:00 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:56007 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1031337AbWLAM77 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 07:59:59 -0500
Date: Fri, 1 Dec 2006 13:59:33 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] avr32: Fixup kprobes preemption handling.
Message-ID: <20061201135933.3d166c91@dhcp-252-105.norway.atmel.com>
In-Reply-To: <20061201075050.GA30051@linux-sh.org>
References: <20061201075050.GA30051@linux-sh.org>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 16:50:50 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> While working on SH kprobes, I noticed that avr32 got the preemption
> handling wrong in the no probe case. The idea is that upon entry of
> kprobe_handler() preemption is disabled outright across the life of
> the kprobe, only to be re-enabled in post_kprobe_handler().
> 
> However, in the event that the probe is never activated, there's never
> any chance of hitting the post probe handler, which allows for the
> current avr32 implementation to disable preemption indefinitely, as
> it's currently missing a re-enable when no probe is activated.

You're absolutely right. Thanks for the patch, I've added it to my tree.

Håvard
