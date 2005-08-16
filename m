Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbVHPSgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbVHPSgr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 14:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVHPSgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 14:36:47 -0400
Received: from dsl027-180-204.sfo1.dsl.speakeasy.net ([216.27.180.204]:25576
	"EHLO outer-richmond.davemloft.net") by vger.kernel.org with ESMTP
	id S1030290AbVHPSgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 14:36:46 -0400
Date: Tue, 16 Aug 2005 11:36:34 -0700 (PDT)
Message-Id: <20050816.113634.43780066.davem@davemloft.net>
To: kern@sibbald.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: blocking read on socket repeatedly returns EAGAIN
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200508161519.39719.kern@sibbald.com>
References: <200508161519.39719.kern@sibbald.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kern Sibbald <kern@sibbald.com>
Subject: PROBLEM: blocking read on socket repeatedly returns EAGAIN
Date: Tue, 16 Aug 2005 15:19:39 +0200

> A read() on a TCP/IP socket, which should block returns -1 with errno=EAGAIN

If a signal is delivered to the process during the read(),
then -EAGAIN is perfectly valid.
