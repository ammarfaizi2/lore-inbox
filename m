Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932193AbVKNWCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbVKNWCs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 17:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVKNWCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 17:02:47 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:23499 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932178AbVKNWCc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 17:02:32 -0500
Subject: Re: [2.6 patch] i386: always use 4k stacks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dlal2q$kdo$1@sea.gmane.org>
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com>
	 <1131979779.5751.17.camel@localhost.localdomain>
	 <dlal2q$kdo$1@sea.gmane.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 14 Nov 2005 22:33:57 +0000
Message-Id: <1132007638.16148.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-11-14 at 13:29 -0500, Giridhar Pemmasani wrote:
> If this 4k stack patch makes into mainstream, I am wondering what options,
> other than maintaining a patch to back this patch, are available. The last
> time this issue came up some people suggested pushing ndiswrapper into user
> space. However, AFAIK this is non-trivial; I looked into FUSD
> http://www.circlemud.org/~jelson/software/fusd/ which doesn't support
> network drivers and seems to be not active in the recent past.
> 
> Any suggestions on how ndiswrapper can live with this patch would be greatly
> appreciated.


Switch stack before calling the Windows bits. If we take an IRQ then the
kernel will itself switch to its own IRQ stack for the IRQ handling. I
don't think there is much more required.

