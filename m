Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWGXRQu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWGXRQu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWGXRQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:16:50 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:44571 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S932225AbWGXRQt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:16:49 -0400
Subject: [Patch 0/2] CPU hotplug compatible alloc_percpu
From: Martin Peschke <mp3@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 19:16:42 +0200
Message-Id: <1153761402.2986.134.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1/2 addresses alloc_percpu's generous way of grabbing memory for
offline cpu's. It allows clients to fix up per-cpu data in their CPU
hotplug handlers, avoiding waste of memory for unused cpu's.
The existing alloc_percpu() / free_percpu() interface has been
reimplemented on top of the enhanced interface.

Patch 2/2 moves the statistic infrastructure over to the enhanced
interface.

This thread lead this patch set:
http://marc.theaimsgroup.com/?l=linux-kernel&m=115270746121933&w=2

Patches are against 2.6.18-rc1-mm2.

Tested on s390, SMP (w/ and w/o cpu hotplug), and UP.

