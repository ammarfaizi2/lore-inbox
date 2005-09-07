Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbVIGSwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbVIGSwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVIGSwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:52:19 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:39634 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750776AbVIGSwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:52:19 -0400
Subject: RE: kbuild & C++
From: Lee Revell <rlrevell@joe-job.com>
To: "Budde, Marco" <budde@telos.de>
Cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
In-Reply-To: <809C13DD6142E74ABE20C65B11A2439809C4BF@www.telos.de>
References: <809C13DD6142E74ABE20C65B11A2439809C4BF@www.telos.de>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 14:52:13 -0400
Message-Id: <1126119134.13159.82.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.8 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 12:17 +0200, Budde, Marco wrote:
> Well, it is not the first driver I am writing for Linux.
> So yes, I do know, what is part of a Linux driver and
> what is not.

It should be fairly obvious.  Windows drivers do all kinds of crap that
just obviously doesn't belong in the kernel, often to implement features
that Windows doesn't have.  For example half the Windows sound drivers
do AC3 decoding inside the driver (and half of those lie and say it's a
hardware AC3 decoder).

On Linux we use a simple userspace program called ac3dec for that.

Anything that can reasonably be done in userspace belongs in userspace.
We DON'T do things in the kernel just because it would be slightly
faster or it has an RT constraint or the kernel lacks some feature that
your driver wants or whatever.

Lee

