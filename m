Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261573AbVFHTqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVFHTqj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVFHTqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:46:39 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33733
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261573AbVFHTqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:46:33 -0400
Date: Wed, 08 Jun 2005 12:46:26 -0700 (PDT)
Message-Id: <20050608.124626.95058471.davem@davemloft.net>
To: flexy@ee.oulu.fi
Cc: linux-kernel@vger.kernel.org
Subject: Re: tcp_output.c BUG in 2.6.12-rc6-mm1 report
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050608182638.GA13553@ee.oulu.fi>
References: <20050604195352.GA192@ee.oulu.fi>
	<20050608182638.GA13553@ee.oulu.fi>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just remove the BUG_ON() statement in tcp_tso_should_defer(), the
assertion is just incorrect.
