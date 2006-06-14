Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWFNWOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWFNWOA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 18:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932405AbWFNWOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 18:14:00 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:27283
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932397AbWFNWOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 18:14:00 -0400
Date: Wed, 14 Jun 2006 15:14:18 -0700 (PDT)
Message-Id: <20060614.151418.32173686.davem@davemloft.net>
To: bofh1234567@yahoo.com
Cc: alan@lxorguk.ukuu.org.uk, jengelh@linux01.gwdg.de,
       linux-kernel@vger.kernel.org
Subject: Re: SO_REUSEPORT and multicasting
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060614174825.94383.qmail@web53612.mail.yahoo.com>
References: <1150296668.3490.46.camel@localhost.localdomain>
	<20060614174825.94383.qmail@web53612.mail.yahoo.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Instead of degenerating this mailing list into a BSD socket
programming class, you may find this informative:

	http://www.unixguide.net/network/socketfaq/4.11.shtml

and it's covered extensively in W. Richard Steven's book, TCP/IP
Illustrated, Volume 2.  It is considered the bible on BSD socket
programming.

Particularly telling is the final paragraph from that web page which
reads:

	Basically SO_REUSEPORT is a BSD'ism that arose when
	multicast was added, evne though it was not used in the
	original Steve Deering code.  I believe some BSD-derived
	systems may also include it.  SO_REUSEPORT lets you bind
	the same address *and* port, but only if all the binders
	have specified it.  But when binding to multicast address
	(its main use), SO_REUSEADDR is considered identical to
	SO_REUSEPORT (p. 731, "TCP/IP Illustrated, Volume 2").
	So for portability of multicast applications, I always
	use SO_REUSEADDR.

I STRONGLY suggest you go read that reference to page 731 in
the Steven book.
