Return-Path: <linux-kernel-owner+w=401wt.eu-S1751134AbWLLE1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWLLE1h (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 23:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWLLE1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 23:27:37 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:54373
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751065AbWLLE1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 23:27:37 -0500
Date: Mon, 11 Dec 2006 20:27:35 -0800 (PST)
Message-Id: <20061211.202735.104033567.davem@davemloft.net>
To: dada1@cosmosbay.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Introduce jiffies_32 and related compare functions
From: David Miller <davem@davemloft.net>
In-Reply-To: <457E2B73.9040307@cosmosbay.com>
References: <457E2642.2000103@cosmosbay.com>
	<20061211.195737.71090466.davem@davemloft.net>
	<457E2B73.9040307@cosmosbay.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Tue, 12 Dec 2006 05:09:23 +0100

> We definitly *like* being able to use bigger timeouts on 64bits platforms.
> 
> Not that they are mandatory since the same application should run fine on 
> 32bits kernel. But as the standard type for 'tick timestamps' is 'unsigned 
> long', a change would be invasive.
>
> Maybe some applications are now relying on being able to
> sleep()/select()/poll() for periods > 30 days and only run on 64
> bits kernels.

I think one possible target would be struct timer, at least
in theory.

There is also a line of reasoning that says that on 64-bit
platforms we have some flexibility to set HZ very large, if
we wanted to at some point, and going to 32-bit jiffies
storage for some things may eliminate that kind of flexibility.

Just some food for thought...
