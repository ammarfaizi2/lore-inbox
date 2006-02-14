Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422648AbWBNVFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWBNVFw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422672AbWBNVFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:05:51 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:28899 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422648AbWBNVFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:05:44 -0500
Date: Tue, 14 Feb 2006 21:05:38 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Mark Lord <lkml@rtr.ca>, "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add cast to __iomem pointer in scsi drivers
Message-ID: <20060214210538.GF27946@ftp.linux.org.uk>
References: <s5hzmktaecj.wl%tiwai@suse.de> <Pine.LNX.4.61.0602141530420.32364@chaos.analogic.com> <s5hu0b1ad2o.wl%tiwai@suse.de> <43F2419E.9060308@rtr.ca> <s5hslqlac86.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hslqlac86.wl%tiwai@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2006 at 09:59:05PM +0100, Takashi Iwai wrote:
> Yes, that'll be the best solution.  But, in these drivers, the same
> struct fields are used for both inl() and writel() depending on the
> flag, so you cannot change the type.
> 
> Hm, looks like I hit a dreadful case without a good solution.

ioread*/iowrite*
