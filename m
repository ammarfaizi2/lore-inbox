Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTFBULV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 16:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbTFBULV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 16:11:21 -0400
Received: from 12-208-246-150.client.attbi.com ([12.208.246.150]:35849 "EHLO
	archimedes.mayer") by vger.kernel.org with ESMTP id S261769AbTFBULU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 16:11:20 -0400
Date: Mon, 2 Jun 2003 14:24:44 -0600
To: Jocelyn Mayer <jma@netgem.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] radeonfb doesn't compile in 2.4.21-rc6
Message-ID: <20030602202444.GA9876@galileo>
Mail-Followup-To: James Mayer <james@cobaltmountain.com>,
	Jocelyn Mayer <jma@netgem.com>, linux-kernel@vger.kernel.org
References: <1054578295.4951.34.camel@jma1.dev.netgem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1054578295.4951.34.camel@jma1.dev.netgem.com>
User-Agent: Mutt/1.5.4i
From: James Mayer <james@cobaltmountain.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 08:24:56PM +0200, Jocelyn Mayer wrote:
> It seems to me that this was already reported for previous
> 2.4.21-rc's, but never applied.
> Here's the patch that make radeonfb compile (and work)
> on my Ibook:
>
>
> 19:06:04.0000
> 00000 +0200
> +++ linux-2.4.21-rc6-fixed/drivers/video/radeonfb.c    2003-06-01
> 20:58:42.0000
> 00000 +0200
> @@ -1001,8 +1001,8 @@
>         /* According to XFree86 4.2.0, some production M6's return 0
>            for 8MB. */
>         if (rinfo->video_ram == 0 &&
> -           (pdev->device == PCI_DEVICE_ID_RADEON_LY ||
> -            pdev->device == PCI_DEVICE_ID_RADEON_LZ)) {
> +           (pdev->device == PCI_DEVICE_ID_ATI_RADEON_LY ||
> +            pdev->device == PCI_DEVICE_ID_ATI_RADEON_LZ)) {
>             rinfo->video_ram = 8192 * 1024;
>           }

Hi,

I can't seem to find PCI_DEVICE_ID_ATI_RADEON_LY or
PCI_DEVICE_ID_ATI_RADEON_LZ defined *anywhere* in 2.4.21-rc6, and the
2.4.21-rc6 version of radeonfb.c compiled just fine for me.

 - James
