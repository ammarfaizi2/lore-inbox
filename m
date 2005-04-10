Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261555AbVDJSjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbVDJSjf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 14:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVDJSjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 14:39:35 -0400
Received: from mail1.kontent.de ([81.88.34.36]:3283 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261555AbVDJSjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 14:39:32 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
Date: Sun, 10 Apr 2005 20:40:38 +0200
User-Agent: KMail/1.7.1
Cc: pavel@suse.cz, Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <42592697.8060909@domdv.de>
In-Reply-To: <42592697.8060909@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504102040.38403.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 10. April 2005 15:13 schrieb Andreas Steinmetz:
> It may not be desireable to leave swsusp saved pages on disk after
> resume as they may contain sensitive data that was never intended to be
> stored on disk in an way (e.g. in-kernel dm-crypt keys, mlocked pages).
> 
> The attached simple patch against 2.6.11.2 should fix this by zeroing
> the swap pages after reading them.

What is the point in doing so after they've rested on the disk for ages?
If you want secure swsusp you need to encrypt the image.

	Regards
		Oliver
