Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWFUAeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWFUAeZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 20:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWFUAeZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 20:34:25 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:23685
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932212AbWFUAeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 20:34:24 -0400
Date: Tue, 20 Jun 2006 17:34:34 -0700 (PDT)
Message-Id: <20060620.173434.35660839.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
CC: torvalds@osdl.org, akpm@osdl.org, dwmw2@infradead.org
Subject: cfq-iosched.c:RB_CLEAR_COLOR
From: David Miller <davem@davemloft.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That got removed in Linus's tree today, yet cfq-iosched.c
still contains a reference to it.

The culprit changeset seems to be 3db3a44.

There were two explicit calls in the cfq-iosched.c file
to RB_CLEAR_COLOR, only the one in cfq_del_crq_rb() got
removed so the build fails.
