Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264494AbTFKVun (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTFKVun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:50:43 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:65213 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S264494AbTFKVum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:50:42 -0400
To: "David Schwartz" <davids@webmaster.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: select for UNIX sockets?
References: <MDEHLPKNGKAHNMBLJOLKGEDDDJAA.davids@webmaster.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 12 Jun 2003 00:04:21 +0200
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEDDDJAA.davids@webmaster.com>
Message-ID: <m3vfvcl196.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> writes:

> 	Looks like another receive queue to me. There is no send queue and you
> wouldn't want there to be one.

So?

> 	They have device queues, they have no socket send queues.

Well?

> > Having no per-sender socket queue for UDP/IP is totally irrelevant here.
> 
> 	It is relevent. Because when you select for write, you're trying to
> find
> out whether there's space to write to the socket.

Which socket? IP/UDP or UNIX one? You know, UNIX sockets are a little
special - both ends are on the same machine. This is why the sending
routine can check the receiving queue length.

> That would require there
> to be something for there to be space in or not to be space in. Whatever you
> want to call that (I call it a 'socket send queue', but it doesn't matter)
> that queue doesn't exist for UDP and you wouldn't want it to exist.

Sure.


> 	With UDP, or any connectionless protocol, the application is ultimately
> responsible for transmit pacing.

Still, this is all irrelevant, this is a kernel-only issue.

> You could argue that it would be nice if
> the kernel helped out more than it currently does, but it has no obligation
> to do so.

You're missing the fact that the kernel _has_ code to help but this
_existing_ code is broken (and yes, it was fine in earlier kernels).
-- 
Krzysztof Halasa
Network Administrator
