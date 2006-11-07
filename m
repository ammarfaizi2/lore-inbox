Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753740AbWKGHHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753740AbWKGHHx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 02:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754076AbWKGHHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 02:07:52 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:17847
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1753711AbWKGHHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 02:07:52 -0500
Date: Mon, 06 Nov 2006 23:07:55 -0800 (PST)
Message-Id: <20061106.230755.38710002.davem@davemloft.net>
To: neilb@suse.de
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: TCP stack sometimes loses ACKs ... or something
From: David Miller <davem@davemloft.net>
In-Reply-To: <17744.10620.389409.136737@cse.unsw.edu.au>
References: <17744.10620.389409.136737@cse.unsw.edu.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Window scaling... there is some intermediate device which is
trying to prevent "out of window" segments from passing through,
but it is not taking the negotiated window scale into account.
So it thinks that segments are outside of the window, when they
are not.
