Return-Path: <linux-kernel-owner+w=401wt.eu-S1751827AbWLNASS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbWLNASS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWLNASS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:18:18 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53512
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751823AbWLNASR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:18:17 -0500
Date: Wed, 13 Dec 2006 16:18:16 -0800 (PST)
Message-Id: <20061213.161816.85689247.davem@davemloft.net>
To: tgraf@suug.ch
Cc: bunk@stusta.de, shemminger@osdl.org, viro@ftp.linux.org.uk,
       jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/loopback.c: convert to module_init()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061213231848.GY8693@postel.suug.ch>
References: <20061213150143.2672e0b1@dxpl.pdx.osdl.net>
	<20061213231217.GB3629@stusta.de>
	<20061213231848.GY8693@postel.suug.ch>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Graf <tgraf@suug.ch>
Date: Thu, 14 Dec 2006 00:18:48 +0100

> Not really, the device management inits as subsys, the ip layer hooks
> into fs_initcall() which comes right after. The loopback was actually
> registered after the protocol so far. I think Adrian's patch is fine
> if the module_init() is changed to device_initcall().

module_init == device_initcall when the object is being compiled
statically into the kernel, which is always the case for the loopback
driver

I mentioned this in my original reply to Adrian, just in case anyone
happened to actually read that :-)
