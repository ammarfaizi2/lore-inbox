Return-Path: <linux-kernel-owner+w=401wt.eu-S1755264AbXABFBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755264AbXABFBK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 00:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755265AbXABFBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 00:01:10 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:53493
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755264AbXABFBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 00:01:09 -0500
Date: Mon, 01 Jan 2007 21:01:08 -0800 (PST)
Message-Id: <20070101.210108.41636312.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: segher@kernel.crashing.org, hch@infradead.org,
       linux-kernel@vger.kernel.org, devel@laptop.org, dmk@flex.com,
       wmb@firmworks.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <1167713825.6165.54.camel@localhost.localdomain>
References: <1167710760.6165.32.camel@localhost.localdomain>
	<20070101.203043.112622209.davem@davemloft.net>
	<1167713825.6165.54.camel@localhost.localdomain>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 02 Jan 2007 15:57:05 +1100

> I like being able to have a simple way (ie. tar /proc/device-tree) to
> tell user to send me their DT and have in the end an exact binary
> representation so I can actually dig for problems, like a wrong phandle
> in an interrupt-map or stuff like that...

"prtconf -pv" is what I'd ask the user to do on Sparc, or something
similar.

In over 10 years of the sparc port there's never been a situation
where "prtconf -pv" or similar did not get me the information I
needed. :-)

"prtconf" walks the device tree raw using /dev/openprom and
pretty prints it like I assume your ppc "lsprop" thing does.

