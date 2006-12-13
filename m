Return-Path: <linux-kernel-owner+w=401wt.eu-S1750866AbWLMUtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWLMUtP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWLMUtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:49:14 -0500
Received: from postel.suug.ch ([194.88.212.233]:60164 "EHLO postel.suug.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838AbWLMUtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:49:14 -0500
Date: Wed, 13 Dec 2006 21:49:33 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: David Miller <davem@davemloft.net>, bunk@stusta.de, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/loopback.c: convert to module_init()
Message-ID: <20061213204933.GW8693@postel.suug.ch>
References: <20061212162435.GW28443@stusta.de> <20061212.171756.85408589.davem@davemloft.net> <20061213201213.GK4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213201213.GK4587@ftp.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Al Viro <viro@ftp.linux.org.uk> 2006-12-13 20:12
> On Tue, Dec 12, 2006 at 05:17:56PM -0800, David Miller wrote:
> > I'm not sure whether that is important any longer.  It probably isn't,
> > but we should verify it before applying such a patch.
> 
> There might be practical considerations along the lines of "we want
> lookups for loopback to be fast"...

What is this discussion actually about? Since we started registering
devices directly hooked into the init process before device_initcall()
the order is random. Even the bonding device is registered before the
loopback.
