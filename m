Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262199AbUKRITD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbUKRITD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 03:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUKRITC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 03:19:02 -0500
Received: from colino.net ([213.41.131.56]:42995 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S262199AbUKRISA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 03:18:00 -0500
Date: Thu, 18 Nov 2004 09:17:31 +0100
From: Colin Leroy <colin.lkml@colino.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotplug_path no longer exported
Message-ID: <20041118091731.44590d84.colin.lkml@colino.net>
In-Reply-To: <20041117222340.GA4494@kroah.com>
References: <20041117203139.7c9f5e95.colin@colino.net>
	<20041117214824.GA1291@kroah.com>
	<20041117231253.1ec92e6f.colin@colino.net>
	<20041117222340.GA4494@kroah.com>
X-Mailer: Sylpheed-Claws 0.9.12cvs151.1 (GTK+ 2.4.0; i686-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Nov 2004 at 14h11, Greg KH wrote:

Hi, 

> > Dunno. This driver has a reputation of being the worse wlan driver for
> > prism2 chipsets out there, but it's the only one supporting USB devices.
> 
> Hm, I've heard that rumor before too.  If only someone would get me such
> a usb device, maybe that problem could be fixed :)

What's your address ? :)

> Anyway, the proper fix is to use kobject_hotplug().  They will have to
> change their code.  Just one of the many joys of trying to keep a driver
> outside of the main kernel tree...

I also just noticed they do their hotplug stuff in p80211.c, which knows 
nothing of USB. What a hack :-/

-- 
Colin
