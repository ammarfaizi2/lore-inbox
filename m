Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266539AbUHBO1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266539AbUHBO1E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 10:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUHBO1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 10:27:04 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:65495 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266539AbUHBO0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 10:26:52 -0400
Date: Mon, 2 Aug 2004 10:30:31 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: finding out the boot cpu number from userspace
In-Reply-To: <20040802121635.GE14477@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0408021028010.4095@montezuma.fsmlabs.com>
References: <20040802121635.GE14477@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004, Arjan van de Ven wrote:

> assuming cpu 0 is the boot cpu sounds fragile/incorrect, but for irqbalanced
> I'd like to find out which cpu is the boot cpu, is there a good way of doing
> so ?
>
> The reason for needing this is that some firmware only likes running on the
> boot cpu so I need to bind firmware-related irq's to that cpu ideally.

How about something like mptable which will give you the BSP flag from the
MP table? I believe this gropes around /dev/mem.
