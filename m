Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVEBOQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVEBOQU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 10:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVEBOQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 10:16:20 -0400
Received: from [195.23.16.24] ([195.23.16.24]:26579 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261260AbVEBOQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 10:16:17 -0400
Message-ID: <4276362B.1010004@grupopie.com>
Date: Mon, 02 May 2005 15:16:11 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Broadbent <markb@wetlettuce.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, netdev@oss.sgi.com
Subject: Re: [PATCH] Tulip interrupt uses non IRQ safe spinlock
References: <E1DRFqC-00028H-Qi@tigger>
In-Reply-To: <E1DRFqC-00028H-Qi@tigger>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Broadbent wrote:
> The interrupt handling code in the tulip network driver appears to use a non 
> IRQ safe spinlock in an interrupt context.  The following patch should correct 
> this.

Huh? Can a network interrupt handler be interrupted by the same interrupt?

AFAIK, the spin_lock_irqsave is to disable interruptions so that an
interrupt can not happen in the critical section, so that the interrupt
handler can not make modifications to shared data. Am I wrong?

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

