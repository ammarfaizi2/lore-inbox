Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbTIHJev (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 05:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTIHJeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 05:34:24 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:59594 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262168AbTIHJdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 05:33:39 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4, b44 transmit timeout
Date: Mon, 8 Sep 2003 11:34:17 +0200
User-Agent: KMail/1.5.3
Cc: pp@ee.oulu.fi
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309081134.17013.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 09:33:53AM +0200, Norbert Preining wrote:  

> A-ha! Thanks, I think this should be enough to figure out what the problem  
> is... Looks like the driver doesn't even get the packets pump tries to send,  
> pump is a bit special in the way it bounces the interface up and down when  
> doing its work, that probably triggers a race in b44..

I can also easily recreate this by calling dhcpcd e.g. when the cable isn't in 
the socket yet. If i attach the cable then I see the interface coming up, 
going down, and then the NETDEV watchdog message.

Unfortunatly this usually means that dhcpcd goes hanging. ifconfig hangs too 
if I try to use it, and rebooting must be forced with sysrq and an oops a 
alt-sysrq-o for poweroff...

Jan

