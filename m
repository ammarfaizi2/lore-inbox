Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270342AbTHQNd0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 09:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270345AbTHQNd0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 09:33:26 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32273 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270342AbTHQNdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 09:33:25 -0400
Date: Sun, 17 Aug 2003 14:33:13 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Trying to run 2.6.0-test3
Message-ID: <20030817143313.A22402@flint.arm.linux.org.uk>
Mail-Followup-To: Norman Diamond <ndiamond@wta.att.ne.jp>,
	linux-kernel@vger.kernel.org
References: <135601c36495$85e507b0$1aee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <135601c36495$85e507b0$1aee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Sun, Aug 17, 2003 at 04:59:34PM +0900
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 04:59:34PM +0900, Norman Diamond wrote:
> 2.6.0-test3 gets it wrong:
> Aug 17 16:39:01 diamondpana cardmgr[540]: socket 1: KME KXLC005 CD-ROM
> Aug 17 16:39:01 diamondpana cardmgr[540]: executing: 'modprobe -v ide_cs'
> Aug 17 16:39:02 diamondpana cardmgr[540]: + insmod /lib/modules/2.6.0-test3/kernel/drivers/ide/legacy/ide-cs.ko
> Aug 17 16:39:02 diamondpana cardmgr[540]: bind 'ide_cs' to socket 1 failed: Invalid argument

Not quite.  This is an old problem dating back several years to early 2.4
times.  Back in the dark old days, ide-cs used to use the name "ide_cs" to
bind the driver to the device.  It now uses "ide-cs" for binding.

Make sure that "ide_cs" isn't mentioned in /etc/pcmcia/config - if it
is, change it to "ide-cs".

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

