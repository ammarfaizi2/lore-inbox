Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265155AbTLWPBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 10:01:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265158AbTLWPBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 10:01:09 -0500
Received: from zero.aec.at ([193.170.194.10]:32004 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S265155AbTLWPBH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 10:01:07 -0500
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
From: Andi Kleen <ak@muc.de>
Date: Mon, 22 Dec 2003 23:29:56 +0100
In-Reply-To: <15Gg9-4H6-25@gated-at.bofh.it> (Christophe Saout's message of
 "Mon, 22 Dec 2003 23:00:25 +0100")
Message-ID: <m3d6aga3kr.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <15G6g-4oz-17@gated-at.bofh.it> <15Gg9-4H6-25@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> writes:

> this is the actual dm-crypt target. It uses cryptoapi to achive the same
> goal as cryptoloop.
>
> It uses mempools to ensure not to ever run out of memory and can split
> large IOs into smaller ones under memory pressure.
>
> Tested by some people, also works on a swap device.

Is the IV argument compatible to block backed loop? 

If not it would not be possible to use existing block based
loop crypto file systems this way.

-Andi
