Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbVINTFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbVINTFZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 15:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbVINTFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 15:05:25 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:26284
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932563AbVINTFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 15:05:24 -0400
Date: Wed, 14 Sep 2005 12:05:18 -0700 (PDT)
Message-Id: <20050914.120518.92662608.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH]: Brown paper bag in fs/file.c?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050914.114821.13027704.davem@davemloft.net>
References: <20050914.113133.78024310.davem@davemloft.net>
	<20050914.114821.13027704.davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 14 Sep 2005 11:48:21 -0700 (PDT)

> From: "David S. Miller" <davem@davemloft.net>
> Date: Wed, 14 Sep 2005 11:31:33 -0700 (PDT)
> 
> > I'm about to reboot to see if this fixes the sparc64 problem, with my
> > luck it probably won't :-)
> 
> It doesn't, but I think the patch is correct regardless.

Studying fs/file.c a bit more, there seems to be several of these
"size vs nr" errors in the allocation and freeing code.

What's going on here?
