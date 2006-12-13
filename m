Return-Path: <linux-kernel-owner+w=401wt.eu-S1750748AbWLMUml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWLMUml (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWLMUml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:42:41 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41972 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748AbWLMUmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:42:40 -0500
X-Greylist: delayed 1818 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 15:42:40 EST
Date: Wed, 13 Dec 2006 20:12:14 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: bunk@stusta.de, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/loopback.c: convert to module_init()
Message-ID: <20061213201213.GK4587@ftp.linux.org.uk>
References: <20061212162435.GW28443@stusta.de> <20061212.171756.85408589.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061212.171756.85408589.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 05:17:56PM -0800, David Miller wrote:
> From: Adrian Bunk <bunk@stusta.de>
> Date: Tue, 12 Dec 2006 17:24:35 +0100
> 
> > This patch converts drivers/net/loopback.c to using module_init().
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> I'm not %100 sure of this one, let's look at the comment you
> are deleting:
> 
> > -/*
> > - *	The loopback device is global so it can be directly referenced
> > - *	by the network code. Also, it must be first on device list.
> > - */
> > -extern int loopback_init(void);
> > -
> 
> in particular notice the part that says "it must be first on the
> device list".
> 
> I'm not sure whether that is important any longer.  It probably isn't,
> but we should verify it before applying such a patch.

There might be practical considerations along the lines of "we want
lookups for loopback to be fast"...
