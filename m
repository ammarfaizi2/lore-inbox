Return-Path: <linux-kernel-owner+w=401wt.eu-S932541AbWLMOUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932541AbWLMOUq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 09:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWLMOUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 09:20:46 -0500
Received: from postel.suug.ch ([194.88.212.233]:58520 "EHLO postel.suug.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932509AbWLMOUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 09:20:45 -0500
X-Greylist: delayed 1570 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 09:20:45 EST
Date: Wed, 13 Dec 2006 14:54:56 +0100
From: Thomas Graf <tgraf@suug.ch>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Miller <davem@davemloft.net>, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/loopback.c: convert to module_init()
Message-ID: <20061213135456.GU8693@postel.suug.ch>
References: <20061212162435.GW28443@stusta.de> <20061212.171756.85408589.davem@davemloft.net> <20061213134042.GI3851@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061213134042.GI3851@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk <bunk@stusta.de> 2006-12-13 14:40
> Additionally:
> - it works for me (but my e100 is always initialized before loop)
> - I didn't spot any obvious interdependency with the other Space.c
>   drivers
> 
> It could be I missed anything, but I don't see any better way to verify 
> this than getting the patch into the next -mm and wait whether someone 
> will scream...

The loopback was traditionally on ifindex 1, some userspace applications
even relied on it but that is no longer true. I think this is safe.
