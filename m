Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbWF1Qeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbWF1Qeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWF1Qeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:34:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:14274 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751382AbWF1Qee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:34:34 -0400
Subject: Re: [PATCH] ia64: change usermode HZ to 250
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Daiker <jdaiker@osdl.org>
Cc: John Hawkes <hawkes@sgi.com>, Arjan van de Ven <arjan@infradead.org>,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       Jeremy Higdon <jeremy@sgi.com>
In-Reply-To: <44A2AA2B.3090101@osdl.org>
References: <20060627220139.3168.69409.sendpatchset@tomahawk.engr.sgi.com>
	 <1151483994.3153.5.camel@laptopd505.fenrus.org>
	 <005e01c69ac9$a55e1bf0$6f00a8c0@comcast.net>
	 <1151511668.15166.34.camel@localhost.localdomain>
	 <44A2AA2B.3090101@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 28 Jun 2006 17:50:38 +0100
Message-Id: <1151513438.15166.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-28 am 09:11 -0700, ysgrifennodd John Daiker: 
> people should have been using the syscall to begin with... we're just 
> forcing it on them this way!  :-)  That's my $0.02

In the cached HZ case there will be no performance hit of measure
anyway. The bigger problem is existing user space. That is why we've
always kept the user visible HZ based values the same when changing the
kernel HZ. You can't automatically regenerate all the old binaries you
might otherwise break.

Performance is only a minor issue, and I doubt anyone who cared about
performance would be using ia-64 anyway

[Grabs coat and exits..]


