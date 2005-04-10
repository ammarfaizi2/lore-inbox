Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261588AbVDJUC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbVDJUC1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 16:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbVDJUC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 16:02:27 -0400
Received: from mail1.kontent.de ([81.88.34.36]:50826 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261588AbVDJUCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 16:02:24 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
Date: Sun, 10 Apr 2005 22:03:29 +0200
User-Agent: KMail/1.7.1
Cc: pavel@suse.cz, Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <42592697.8060909@domdv.de> <200504102040.38403.oliver@neukum.org> <42597E99.8010802@domdv.de>
In-Reply-To: <42597E99.8010802@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504102203.29602.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 10. April 2005 21:29 schrieb Andreas Steinmetz:
> Oliver Neukum wrote:
> > What is the point in doing so after they've rested on the disk for ages?
> 
> The point is not physical access to the disk but data gathering after
> resume or reboot.

After resume or reboot normal access control mechanisms will work
again. Those who can read a swap partition under normal circumstances
can also read /dev/kmem. It seems to me like you are putting an extra
lock on a window on the third floor while leaving the front door open.

	Regards
		Oliver
