Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVANDRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVANDRT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 22:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbVANDQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 22:16:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:16302 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261874AbVANDGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 22:06:12 -0500
Date: Thu, 13 Jan 2005 19:05:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Michal Ludvig <michal@logix.cz>
Cc: davem@davemloft.net, jmorris@redhat.com, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PadLock processing multiple blocks at a time
Message-Id: <20050113190536.11850b63.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0501111808170.7104@maxipes.logix.cz>
References: <Xine.LNX.4.44.0411301009560.11945-100000@thoron.boston.redhat.com>
	<Pine.LNX.4.61.0411301722270.4409@maxipes.logix.cz>
	<20041130222442.7b0f4f67.davem@davemloft.net>
	<Pine.LNX.4.61.0412031353120.17402@maxipes.logix.cz>
	<Pine.LNX.4.61.0501111808170.7104@maxipes.logix.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Ludvig <michal@logix.cz> wrote:
>
> # 
> # Update to padlock-aes.c that enables processing of the whole 
> # buffer of data at once with the given chaining mode (e.g. CBC).
> # 

Please don't email different patche sunder the same Subject:.  Choose a
Subject: which is meaningful for each patch?

This one kills gcc-2.95.x:

drivers/crypto/padlock-aes.c: In function `aes_padlock':
drivers/crypto/padlock-aes.c:391: impossible register constraint in `asm'
drivers/crypto/padlock-aes.c:402: impossible register constraint in `asm'
drivers/crypto/padlock-aes.c:413: impossible register constraint in `asm'
drivers/crypto/padlock-aes.c:391: `asm' needs too many reloads

