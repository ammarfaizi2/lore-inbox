Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265940AbUGEEad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265940AbUGEEad (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 00:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUGEEad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 00:30:33 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:41736 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S265940AbUGEEab
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 00:30:31 -0400
To: Zinx Verituse <zinx@epicsol.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 8139too in 2.6.x tx timeout
References: <20040626222304.GA31195@bliss>
	<87hdsoghdv.fsf@devron.myhome.or.jp> <20040704194009.GA2029@bliss>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 05 Jul 2004 13:30:22 +0900
In-Reply-To: <20040704194009.GA2029@bliss>
Message-ID: <873c4713fl.fsf@ibmpc.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zinx Verituse <zinx@epicsol.org> writes:

> Up with some other files:
> http://zinx.xmms.org/misc/tmp/8139too/
> linux-2.6.7-mobius-dotconfig (.config being used for the kernel)

Probably this isn't fix the problem, but can you try the following?

CONFIG_8139TOO_PIO=n
CONFIG_8139TOO_TUNE_TWISTER=n

(both config to "n")

> On the ping -c1: several pings made it, then it didn't reply for one,
> but also reported no timeout in the messages.  Another ping caused it
> to not reply _and_ to timeout/reset.

This may not be the problem of 8139too driver, because 2.4.24's
driver didn't fix.

Umm.. possible of cable or hub problem, but 2.4.24 is work...
Do you know lastest worked version?

> By the way, I downloaded the specs for the 8139C and noticed immediately
> it claims writing to the ISR has no effect and that reading it clears it.
> The drivers appear to indicate this documentation is entirely wrong --
> Is there any real documentation for this chipset?

Indeed. I think you are reading the same document with me. Docs says it,
however, the interrupt status wasn't cleared by read.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
