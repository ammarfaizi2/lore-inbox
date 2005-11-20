Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVKTWfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVKTWfF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 17:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVKTWfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 17:35:05 -0500
Received: from [81.2.110.250] ([81.2.110.250]:45455 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1750795AbVKTWfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 17:35:03 -0500
Subject: Re: [BUG] 2.6.15-rc1, soft lockup detected while probing IDE
	devices on AMD7441
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Alexander V. Inyukhin" <shurick@sectorb.msk.ru>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051120204656.GA17242@shurick.s2s.msu.ru>
References: <20051120204656.GA17242@shurick.s2s.msu.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 20 Nov 2005 23:07:13 +0000
Message-Id: <1132528033.459.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2005-11-20 at 23:46 +0300, Alexander V. Inyukhin wrote:
> I've got soft lockups during IDE probes with 2.6.15-rc1 kernel.
> The box is dual Athlon MP with ASUS A7M266-D board.
> Full dmesg, config and lspci -vvv output are in the attachment.
> Disabling second channel with "hdc=noprobe hdd=noprobe" did not help.

Quite normal. The old IDE probe code takes a long time and it makes the
soft lockup code believe a lockup occurred - rememeber its a debugging
tool not a 100% reliable detector of failures.

Alan

