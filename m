Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424642AbWKPVXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424642AbWKPVXW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 16:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424634AbWKPVXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 16:23:22 -0500
Received: from localhost.localdomain ([127.0.0.1]:37603 "EHLO localhost")
	by vger.kernel.org with ESMTP id S1424639AbWKPVXU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 16:23:20 -0500
Date: Thu, 16 Nov 2006 16:23:20 -0500 (EST)
Message-Id: <20061116.162320.28787779.davem@davemloft.net>
To: eli@dev.mellanox.co.il
Cc: jheffner@psc.edu, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: UDP packets loss
From: David Miller <davem@davemloft.net>
In-Reply-To: <62092.85.250.37.175.1163711408.squirrel@dev.mellanox.co.il>
References: <18154.194.90.237.34.1163703097.squirrel@dev.mellanox.co.il>
	<455CB59F.4030908@psc.edu>
	<62092.85.250.37.175.1163711408.squirrel@dev.mellanox.co.il>
X-Mailer: Mew version 5.1 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: eli@dev.mellanox.co.il
Date: Thu, 16 Nov 2006 23:10:08 +0200 (IST)

> >
> > BTW, TCP will be significantly faster than UDP because with UDP you
> > incur an extra full context switch on every packet.
> >
> 
> Could you elaborate on this a bit more? What kind of context switch?

TCP queues and takes care of all the sending, packetization,
etc. handling asynchronously.  Whereas with UDP every write()
results in a packet on the wire, packets are always emitted
synchronously in process context.

