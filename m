Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964971AbWD0IRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbWD0IRP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:17:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWD0IRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:17:15 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:51378
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964971AbWD0IRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:17:15 -0400
Date: Thu, 27 Apr 2006 01:16:46 -0700 (PDT)
Message-Id: <20060427.011646.41961134.davem@davemloft.net>
To: jan.kiszka@googlemail.com
Cc: simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: Van Jacobson's net channels and real-time
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <58d0dbf10604270109j13ba5208h78f9b4de891370a8@mail.gmail.com>
References: <58d0dbf10604210153r208504d4r4a7f4139e711ff7f@mail.gmail.com>
	<Pine.LNX.4.64.0604212332110.30761-100000@localhost>
	<58d0dbf10604270109j13ba5208h78f9b4de891370a8@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Jan Kiszka" <jan.kiszka@googlemail.com>
Date: Thu, 27 Apr 2006 10:09:06 +0200

> What about this:

Can I recommend a trip to the local university engineering library for
a quick readup on the current state of the art wrt.  packet
classification algorithms?

Barring that, a read of chapter 12 "Packet Classification"
from Networking Algorithmics will give you a great primer.

I'm suggesting this, because all I see is fishing around with
painfully inefficient algorithms.

In any event, the initial net channel implementation will likely just
do straight socket hash lookups identical to how TCP does socket
lookups in the current stack.  Full match on established sockets, and
failing that fall back to the listening socket lookup which allows
some forms of wildcarding.

Thanks.
