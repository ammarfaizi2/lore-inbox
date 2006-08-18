Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbWHRGjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbWHRGjA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 02:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWHRGjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 02:39:00 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:40151
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1750738AbWHRGi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 02:38:59 -0400
Date: Thu, 17 Aug 2006 23:39:10 -0700 (PDT)
Message-Id: <20060817.233910.78711257.davem@davemloft.net>
To: ashok.s.das@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM Please Help
From: David Miller <davem@davemloft.net>
In-Reply-To: <8032e0b00608172322y6e77b9d9v3f8cd73e8a7b454d@mail.gmail.com>
References: <8032e0b00608172322y6e77b9d9v3f8cd73e8a7b454d@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Ashok Shankar Das" <ashok.s.das@gmail.com>
Date: Fri, 18 Aug 2006 11:52:58 +0530

> You start pinging to a perticular IP then there will be no activity.
> If The MOUSE is moved or if scroll wheel is scrolled then The ping
> shows some activity.

The IRQ for the network device is not being enabled properly.  The
MOUSE happens to be on the same shared interrupt as the network
device so when you move it the interrupt handler for the network
device gets invoked too.

Just my guess...

