Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264903AbUASNbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 08:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUASNbV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 08:31:21 -0500
Received: from linux-bt.org ([217.160.111.169]:26576 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S264903AbUASNbU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 08:31:20 -0500
Subject: Problem with CONFIG_SYSCTL disabled
From: Marcel Holtmann <marcel@holtmann.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@redhat.com>
Content-Type: text/plain
Message-Id: <1074519043.6070.93.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 19 Jan 2004 14:30:43 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

with the latest 2.6.1-bk5 I got the following error:

	In file included from drivers/net/net_init.c:53:
	include/net/neighbour.h:216: error: parse error before "proc_handler"
	include/net/neighbour.h:216: warning: function declaration isn't a prototype

Looking for the reason it seems that I have to enable CONFIG_SYSCTL to
make this compile. The following patch introduces this problem:

	ChangeSet@1.1474.82.35, 2004-01-15 00:58:20-08:00, mashirle@us.ibm.com
	  [IPV6]: Implement MIB:ipv6InterfaceTable

Regards

Marcel


