Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbTDUUXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 16:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbTDUUXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 16:23:23 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:16086 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262100AbTDUUXW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 16:23:22 -0400
Date: Mon, 21 Apr 2003 16:35:21 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
In-Reply-To: <20030421215637.A30019@lst.de>
Message-ID: <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com>
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com>
 <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de>
 <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com>
 <20030421210020.A29421@lst.de> <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com>
 <20030421215637.A30019@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh, I see now.  There's a longstanding bug in the handling of
> TTY_DRIVER_NO_DEVFS that got exposed by this.
>
> Please try this patch additionally:

Applied.  Now I can log in by ssh and there are no problems with
pseudoterminals.  However, all local terminals are gone:

INIT: Id "1" respawning too fast: disabled for 5 minutes
INIT: Id "2" respawning too fast: disabled for 5 minutes
INIT: Id "3" respawning too fast: disabled for 5 minutes
INIT: Id "5" respawning too fast: disabled for 5 minutes
INIT: Id "4" respawning too fast: disabled for 5 minutes
INIT: Id "6" respawning too fast: disabled for 5 minutes
INIT: Id "S0" respawning too fast: disabled for 5 minutes
INIT: no more processes left in this runlevel

The only entry under /dev/vc is /dev/vc/0.  /dev/tts is missing.

-- 
Regards,
Pavel Roskin
