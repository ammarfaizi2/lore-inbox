Return-Path: <linux-kernel-owner+w=401wt.eu-S964967AbXABWHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbXABWHv (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932907AbXABWHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:07:51 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33056
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754971AbXABWHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:07:50 -0500
Date: Tue, 02 Jan 2007 14:07:49 -0800 (PST)
Message-Id: <20070102.140749.104035927.davem@davemloft.net>
To: segher@kernel.crashing.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, devel@laptop.org,
       jengelh@linux01.gwdg.de, wmb@firmworks.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <978466dd510f659cd69b67ee7309be28@kernel.crashing.org>
References: <459ABC7C.2030104@firmworks.com>
	<1167770882.6165.76.camel@localhost.localdomain>
	<978466dd510f659cd69b67ee7309be28@kernel.crashing.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 2 Jan 2007 22:37:32 +0100

> Leaving aside the issue of in-memory or not, I don't think
> it is realistic to think any completely common implementation
> will work for this -- it might for current SPARC+PowerPC+OLPC,
> but more stuff will be added over time...

I see nothing supporting this IMHO bogus claim.

If you can traverse the device tree using OFW calls, you
can do it to build the in-kernel copy of the tree too.

How the tree is populated, etc., is not an issue for the
common code, for sure.  Each platform does that in whatever
way is appropriate.

But the tree traversal, getting property values, etc. is indeed
a task for the common code and that is exactly what Ben is
suggesting.
