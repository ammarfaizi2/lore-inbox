Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932632AbWHMApt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932632AbWHMApt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 20:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932630AbWHMApt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 20:45:49 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19101
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932621AbWHMAps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 20:45:48 -0400
Date: Sat, 12 Aug 2006 17:46:07 -0700 (PDT)
Message-Id: <20060812.174607.44371641.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: a.p.zijlstra@chello.nl, riel@redhat.com, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       phillips@google.com
Subject: Re: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060812093706.GA13554@2ka.mipt.ru>
References: <20060812084713.GA29523@2ka.mipt.ru>
	<1155374390.13508.15.camel@lappy>
	<20060812093706.GA13554@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Sat, 12 Aug 2006 13:37:06 +0400

> Does it? I though it is possible to only have 64k of working sockets per
> device in TCP.

Where does this limit come from?

You think there is something magic about 64K local ports,
but if remote IP addresses in the TCP socket IDs are all
different, number of possible TCP sockets is only limited
by "number of client IPs * 64K" and ram :-)
