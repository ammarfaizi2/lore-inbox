Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWEOUoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWEOUoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWEOUoI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:44:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:43224
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751501AbWEOUoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:44:06 -0400
Date: Mon, 15 May 2006 13:43:41 -0700 (PDT)
Message-Id: <20060515.134341.68600281.davem@davemloft.net>
To: jengelh@linux01.gwdg.de
Cc: linux-kernel@vger.kernel.org, ecd@skynet.be
Subject: Re: openpromfs issue
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.61.0605151657510.19978@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0605151657510.19978@yvahk01.tjqt.qr>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Mon, 15 May 2006 17:06:24 +0200 (MEST)

> /proc/openprom# ls -l
> ...
>  88 dr-xr-xr-x  2 root root 0 May 12 11:04 SUNW,UltraSPARC-II@1c,0
>  88 dr-xr-xr-x  2 root root 0 May 12 11:04 SUNW,UltraSPARC-II@1c,0
> ...
> 
> What's wrong is obviously that there cannot be two directories with the 
> same name (and on top, the same inode number).

A long standing and known bug, we don't put enough addressing
information into the node name so you get duplicates.

I have no plans to work on a fix, and if anything openpromfs
deserves a rewrite as it's very old code.
