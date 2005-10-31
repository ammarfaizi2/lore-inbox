Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbVJaSOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbVJaSOu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 13:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVJaSOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 13:14:50 -0500
Received: from [85.8.13.51] ([85.8.13.51]:35732 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932298AbVJaSOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 13:14:49 -0500
Message-ID: <43665F14.9040700@drzeus.cx>
Date: Mon, 31 Oct 2005 19:14:44 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mail/News 1.4.1 (X11/20051008)
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       Felipe Damasio <felipewd@terra.com.br>
Subject: Re: [PATCH] 8139cp: Catch all interrupts
References: <431761BA.5080007@drzeus.cx>
In-Reply-To: <431761BA.5080007@drzeus.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
> Register interrupt handler when net device is registered. Avoids missing
> interrupts if the interrupt mask gets out of sync.
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> 
> ---
> 
> The reason this patch is needed for me is that the resume function is
> broken. It enables interrupts unconditionally, but the interrupt handler
> is only registered when the device is up.
> 
> I don't have enough knowledge about the driver to fix the resume
> function so this patch will instead make sure that the interrupt handler
> is registered at all times (which can be a nice safeguard even when the
> resume function gets fixed).
> 

Any comments on this?
