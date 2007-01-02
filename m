Return-Path: <linux-kernel-owner+w=401wt.eu-S964923AbXABWAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbXABWAA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbXABWAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:00:00 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:50741
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964923AbXABV77 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:59:59 -0500
Date: Tue, 02 Jan 2007 13:59:58 -0800 (PST)
Message-Id: <20070102.135958.41636645.davem@davemloft.net>
To: segher@kernel.crashing.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, devel@laptop.org,
       jengelh@linux01.gwdg.de, wmb@firmworks.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <c7212f93de62c2f7f50be71f257c8974@kernel.crashing.org>
References: <b8370fecbb4a917934b0b163ea5774f5@kernel.crashing.org>
	<1167768494.6165.63.camel@localhost.localdomain>
	<c7212f93de62c2f7f50be71f257c8974@kernel.crashing.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 2 Jan 2007 22:15:50 +0100

> We also can keep the old names as compatibility accessors for
> PowerPC only for a while, until everything is converted -- SPARC
> can do the same then.  You can't really keep the old PowerPC names
> in kernel-wide code anyway, "get_property" is a way too generic
> name for that for example.

That's a simple change for PPC, sed 's/get_property/of_get_property//'
and that's what sparc used since the beginning of it's in-kernel
copy of the device tree implementation.
