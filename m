Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVABPkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVABPkk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 10:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVABPkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 10:40:39 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:43693 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261259AbVABPkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 10:40:33 -0500
Subject: Re: [PATCH] [2.6.10-ac2] Moxa driver causes compile-time errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "M.Baris Demiray" <baris@idealteknoloji.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41D7D2D5.5090407@idealteknoloji.com>
References: <41D7D2D5.5090407@idealteknoloji.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104673453.15004.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 02 Jan 2005 14:36:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-01-02 at 10:54, M.Baris Demiray wrote:
> Hi,
> latest -ac tree patch ac2 replaces some obsolete save_flags()/cli()
> with spin_lock_irqsave() but there are compile time errors caused by
> seems-like-forgotten-to-add-but-used spinlock_t member in moxa_str
> structure. Attached diff file fixes this error and several other
> warnings.

Its still a work in progress. The moxa driver has been defunct since 2.4
and it's not trivial to ressurrect. The majority of moxa hardware uses
mxser which is now happy. Your changes mostly look sane although they
are not enough.



