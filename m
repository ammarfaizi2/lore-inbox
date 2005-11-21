Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVKUB32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVKUB32 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbVKUB32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:29:28 -0500
Received: from smtp.osdl.org ([65.172.181.4]:43999 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932155AbVKUB31 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:29:27 -0500
Date: Sun, 20 Nov 2005 17:29:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: shurick@sectorb.msk.ru, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.6.15-rc1, soft lockup detected while probing IDE
 devices on AMD7441
Message-Id: <20051120172915.31754054.akpm@osdl.org>
In-Reply-To: <1132528033.459.12.camel@localhost.localdomain>
References: <20051120204656.GA17242@shurick.s2s.msu.ru>
	<1132528033.459.12.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>
> On Sul, 2005-11-20 at 23:46 +0300, Alexander V. Inyukhin wrote:
> > I've got soft lockups during IDE probes with 2.6.15-rc1 kernel.
> > The box is dual Athlon MP with ASUS A7M266-D board.
> > Full dmesg, config and lspci -vvv output are in the attachment.
> > Disabling second channel with "hdc=noprobe hdd=noprobe" did not help.
> 
> Quite normal. The old IDE probe code takes a long time and it makes the
> soft lockup code believe a lockup occurred - rememeber its a debugging
> tool not a 100% reliable detector of failures.
> 

We could put a touch_softlockup_watchdog() in there.
