Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbTDUVDi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTDUVDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:03:38 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:47576 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S262134AbTDUVDh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:03:37 -0400
Date: Mon, 21 Apr 2003 17:15:39 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Christoph Hellwig <hch@lst.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.68-bk1 crash in devfs_remove() for defpts files
In-Reply-To: <20030421225704.A30489@lst.de>
Message-ID: <Pine.LNX.4.55.0304211709560.2913@marabou.research.att.com>
References: <Pine.LNX.4.55.0304211338540.1491@marabou.research.att.com>
 <20030421195555.A28583@lst.de> <20030421195847.A28684@lst.de>
 <Pine.LNX.4.55.0304211451110.1798@marabou.research.att.com>
 <20030421210020.A29421@lst.de> <Pine.LNX.4.55.0304211539350.2462@marabou.research.att.com>
 <20030421215637.A30019@lst.de> <Pine.LNX.4.55.0304211630230.2599@marabou.research.att.com>
 <20030421225704.A30489@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Apr 2003, Christoph Hellwig wrote:
>
> The devfs <-> tty interaction are going to drive me nuts.
>
> TTY_DRIVER_NO_DEVFS actually means don't call tty_register_device
> in tty_register_driver, not don't register with devfs.
>
> Updated patch (replaces the last one):

The old story again.  /dev/pts disappears when /dev/pts/0 is unregistered.
"devfs_remove: no entry for pts!" appears on the next attempt to login by
ssh.

/dev/vc and /dev/tts are OK.

-- 
Regards,
Pavel Roskin
