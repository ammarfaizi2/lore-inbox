Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWAWT2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWAWT2B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 14:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWAWT2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 14:28:01 -0500
Received: from hera.kernel.org ([140.211.167.34]:32461 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932110AbWAWT2A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 14:28:00 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller
 11ab:4362 (rev 19)
Date: Mon, 23 Jan 2006 11:27:51 -0800
Organization: OSDL
Message-ID: <20060123112751.2e3f1b15@dxpl.pdx.osdl.net>
References: <43D1C99E.2000506@t-online.de>
	<20060123101538.14d21bf4@dxpl.pdx.osdl.net>
	<43D52C69.5090707@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1138044473 4955 10.8.0.74 (23 Jan 2006 19:27:53 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Mon, 23 Jan 2006 19:27:53 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you try turning off rx checksumming (with ethtool).
	ethtool -K eth0 rx off

There probably still are (generic) bugs in the netfilter code for CHECKSUM_HW
socket buffers.

-- 
Stephen Hemminger <shemminger@osdl.org>
OSDL http://developer.osdl.org/~shemminger
