Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261359AbULTAbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbULTAbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 19:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbULTAbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 19:31:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:32392 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261359AbULTAbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 19:31:22 -0500
Date: Sun, 19 Dec 2004 16:29:58 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: mdharm-usb@one-eyed-alien.net, zaitcev@redhat.com, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Message-ID: <20041219162958.6297b8e6@lembas.zaitcev.lan>
In-Reply-To: <20041220001644.GI21288@stusta.de>
References: <20041220001644.GI21288@stusta.de>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004 01:16:44 +0100, Adrian Bunk <bunk@stusta.de> wrote:

> Is there except for kernel size any good reason for using BLK_DEV_UB 
> instead of USB_STORAGE?

It depends. I like it.

>  config BLK_DEV_UB
>  	tristate "Low Performance USB Block driver"
> -	depends on USB
> +	depends on USB && EMBEDDED

The ub has nothing to do with embedded systems, most of which do not run
with CONFIG_EMBEDDED, BTW.

-- Pete
