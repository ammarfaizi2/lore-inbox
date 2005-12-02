Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751009AbVLBT5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbVLBT5f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 14:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVLBT5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 14:57:35 -0500
Received: from [212.76.84.27] ([212.76.84.27]:516 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750990AbVLBT5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 14:57:34 -0500
From: Al Boldi <a1426z@gawab.com>
To: netdev@vger.kernel.org
Subject: [RFC] ip / ifconfig redesign
Date: Fri, 2 Dec 2005 22:53:19 +0300
User-Agent: KMail/1.5
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512022253.19029.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The current ip / ifconfig configuration is arcane and inflexible.  The reason 
being, that they are based on design principles inherited from the last 
century.

In a GNU/OpenSource environment, OpenMinds should not inhibit themselves 
achieving new design-goals to enable a flexible non-redundant configuration.

Specifically, '#> ip addr ' exhibits this issue clearly, by requiring to 
associate the address to a link instead of the other way around.

Consider this new approach for better address management:
1. Allow the definition of an address pool
2. Relate links to addresses
3. Implement to make things backward-compatible.

The obvious benefit here, would be the transparent ability for apps to bind 
to addresses, regardless of the link existence.

Another benefit includes the ability to scale the link level transparently, 
regardless of the application bind state.

And there may be many other benefits... (i.e. 100% OSI compliance)

--
Al

