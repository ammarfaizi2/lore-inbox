Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267773AbUHaKs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbUHaKs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 06:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267791AbUHaKs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 06:48:26 -0400
Received: from mail36.messagelabs.com ([193.109.254.211]:14504 "HELO
	mail36.messagelabs.com") by vger.kernel.org with SMTP
	id S267773AbUHaKsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 06:48:24 -0400
X-VirusChecked: Checked
X-Env-Sender: okiddle@yahoo.co.uk
X-Msg-Ref: server-8.tower-36.messagelabs.com!1093949302!8945052
X-StarScan-Version: 5.2.10; banners=-,-,-
X-Originating-IP: [158.234.9.163]
X-VirusChecked: Checked
X-StarScan-Version: 5.1.13; banners=.,-,-
From: Oliver Kiddle <okiddle@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Subject: kernel panic (probably XFS related)
Date: Tue, 31 Aug 2004 12:48:01 +0200
Message-ID: <17776.1093949281@trentino.logica.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still having problems with the machine where I previously posted
about page allocation failures. I recently tried upgrading to 2.6.8.1
and it has now crashed twice. When running 2.6.3 the machine is stable:
just the error messages I previously posted about.

Firstly, with 2.6.8.1, I get a number of these messages but they don't
seem to be fatal:
  pagebuf_get: failed to lookup pages

I was around when the second kernel panic occurred so I wrote down some
of the contents of the console.
  Process ypserv  (is mentioned along with pid, threadinfo details)
then:
  Call Trace:
    memmove+0x4d/0x4f
    cache_flusharray+0x4a/0xb6
    kmem_cache_free+0x48/0x4c
    d_callback+0x29/0x3b
    rcu_do_batch+0x14/0x1f
    tasklet_action+0x40/0x61
    __do_softirq+0x7e/0x80
    do_softirq+0x26/0x28
    do_IRQ+0xc4/0xdf
    common_interrupt+0x18/0x20
I may have made mistakes in copying that out. I also wrote down the
register values if they are of any use.

On both occasions, the machine was up for a couple of days before
crashing. Previously problems were triggered by xfsdump but this time
that wasn't running; it was doing it's usual job of handling NIS/NFS for
about 25 clients.

Oliver

PS. Thanks to all the people who helped me out previously.
