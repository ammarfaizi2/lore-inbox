Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWJRIE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWJRIE5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751439AbWJRIE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:04:57 -0400
Received: from natklopstock.rzone.de ([81.169.145.174]:62877 "EHLO
	natklopstock.rzone.de") by vger.kernel.org with ESMTP
	id S1751438AbWJRIE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:04:56 -0400
Date: Wed, 18 Oct 2006 10:04:11 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Ingo Molnar <mingo@elte.hu>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: implicit declaration of function set_irq_chip_and_handler
Message-ID: <20061018080411.GA13340@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Current Linus tree has two new warnings

arch/powerpc/kernel/irq.c: In function irq_dispose_mapping:
arch/powerpc/kernel/irq.c:642: warning: implicit declaration of function set_irq_chip_and_handler
arch/powerpc/sysdev/mpic.c: In function mpic_host_map:
arch/powerpc/sysdev/mpic.c:770: warning: implicit declaration of function set_irq_chip_and_handler

It links anyway for some reason.
There is no prototype anymore, but still many users.

a460e745e8f9c75a0525ff94154a0629f9d3e05d is likely the culprit:
 [PATCH] genirq: clean up irq-flow-type naming

