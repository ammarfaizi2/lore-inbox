Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWHBHZA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWHBHZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 03:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWHBHY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 03:24:59 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:56542
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751320AbWHBHY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 03:24:58 -0400
Date: Wed, 02 Aug 2006 00:25:05 -0700 (PDT)
Message-Id: <20060802.002505.34764840.davem@davemloft.net>
To: johnpol@2ka.mipt.ru
Cc: zach.brown@oracle.com, linux-kernel@vger.kernel.org, drepper@redhat.com,
       netdev@vger.kernel.org
Subject: Re: [take2 1/4] kevent: core files.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060802063918.GB6378@2ka.mipt.ru>
References: <11544248451203@2ka.mipt.ru>
	<44CFEA4B.3060200@oracle.com>
	<20060802063918.GB6378@2ka.mipt.ru>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Date: Wed, 2 Aug 2006 10:39:18 +0400

> u64 is not aligned, so I prefer to use u32 as much as possible.

We have aligned_u64 exactly for this purpose, netfilter makes
use of it to avoid the x86_64 vs. x86 u64 alignment discrepency.
