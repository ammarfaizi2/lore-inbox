Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267671AbUHMXHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267671AbUHMXHm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267726AbUHMXHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:07:42 -0400
Received: from the-village.bc.nu ([81.2.110.252]:50906 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267671AbUHMXHa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:07:30 -0400
Subject: Re: select implementation not POSIX compliant?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nick Palmer <nick@sluggardy.net>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <411D2227.2060500@sluggardy.net>
References: <411A8646.1030205@colorfullife.com>
	 <411D2227.2060500@sluggardy.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092434702.24989.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 23:05:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-13 at 21:18, Nick Palmer wrote:
> Actually Solaris and Linux are consistent in terms of the behavior of
> select in this respect. I suspect that the first select is blocking the
> socket from being used at all, so the second select can't tell that it
> is closed.

The objects are refcounted so the socket hasn't gone away until the
point the select returns.

Alan

