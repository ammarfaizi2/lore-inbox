Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbTFDMsR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 08:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbTFDMsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 08:48:17 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:39040 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261548AbTFDMsR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 08:48:17 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: select for UNIX sockets?
References: <m3llwkauq5.fsf@defiant.pm.waw.pl> <03060406554700.28116@tabby>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 04 Jun 2003 14:42:18 +0200
In-Reply-To: <03060406554700.28116@tabby>
Message-ID: <m3k7c2auad.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard <jesse@cats-chateau.net> writes:

> > select(1024, NULL, [3], NULL, NULL)     = 1 (out [3])
> > sendto(3, "\0", 1, 0, {sa_family=AF_UNIX, path="/tmp/tempUn"}, 13 <<<
> > blocks
> 
> Could. There may be room for the buffer, but unless it is set to nonblock, 
> you may have a stream open to another host that may not accept the data
> (busy,
> network congestion...) With the required acks, the return may (should?) be
> delayed until the ack arrives.

But it's local datagram socket (UNIX). OTOH TCP to remote host should
not block waiting for acks.
-- 
Krzysztof Halasa
Network Administrator
