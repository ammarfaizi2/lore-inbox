Return-Path: <linux-kernel-owner+w=401wt.eu-S1751880AbWLNAhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWLNAhR (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWLNAhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:37:17 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:37140
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751876AbWLNAhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:37:15 -0500
Date: Wed, 13 Dec 2006 16:37:14 -0800 (PST)
Message-Id: <20061213.163714.35660848.davem@davemloft.net>
To: viro@ftp.linux.org.uk
Cc: bunk@stusta.de, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/loopback.c: convert to module_init()
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061213201213.GK4587@ftp.linux.org.uk>
References: <20061212162435.GW28443@stusta.de>
	<20061212.171756.85408589.davem@davemloft.net>
	<20061213201213.GK4587@ftp.linux.org.uk>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 13 Dec 2006 20:12:14 +0000

> There might be practical considerations along the lines of "we want
> lookups for loopback to be fast"...

We have that taken care of, it's called "&loopback_dev".

None of the performance-caring paths do dev_get_by_name("lo")

