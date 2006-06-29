Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbWF2DrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbWF2DrM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 23:47:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWF2DrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 23:47:11 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:65491
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751156AbWF2DrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 23:47:10 -0400
Date: Wed, 28 Jun 2006 20:47:09 -0700 (PDT)
Message-Id: <20060628.204709.41634813.davem@davemloft.net>
To: cat@zip.com.au
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: 2.6.17.1: fails to fully get webpage
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060629030923.GI2149@zip.com.au>
References: <20060629015915.GH2149@zip.com.au>
	<20060628.194627.74748190.davem@davemloft.net>
	<20060629030923.GI2149@zip.com.au>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: CaT <cat@zip.com.au>
Date: Thu, 29 Jun 2006 13:09:23 +1000

> Yup. Must've. Just tried it now and setting tcp_window_scaling to 0
> makes the site load. Sorry about that. Looks like I'll have to remember
> to make sure that gets set to zero on any servers I wind up having to
> upgrade to 2.6.17 and beyond.
> 
> Bugger. :/

You can save yourself that hassle by informing the site admin
of the affected site that they have a firewall that misinterprets
the RFC standard window scaling field of the TCP headers.  These
devices assume it is zero because they don't remember the window
scale negotiated at the beginning of the TCP connection.

Your TCP performance will suffer greatly if you disable window
scaling across the board.  It means that only a 64K window will
be usable by TCP, and you'll not be able to fill the pipe.

Please don't use a screwdriver to pound in a nail :)
