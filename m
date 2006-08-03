Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751351AbWHCUrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbWHCUrs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWHCUrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:47:48 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64213 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751351AbWHCUrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:47:47 -0400
Subject: Re: [PATCH] pSeries  hvsi char driver janitorial cleanup.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linas Vepstas <linas@austin.ibm.com>
Cc: akpm@osdl.org, hollisbl@us.ibm.com, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060803193643.GA10638@austin.ibm.com>
References: <20060803193643.GA10638@austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 22:06:53 +0100
Message-Id: <1154639213.23655.124.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-08-03 am 14:36 -0500, ysgrifennodd Linas Vepstas:
> Andrew, 
> Please apply.
> 
> A set of tty line discipline cleanup patches were introduced 
> before the dawn of time, in kernel version 2.4.21. This patch
> performs that cleanup for the hvsi driver.

Actually its also a bug fix, tty->ldisc should be locked by refcounting
and the helpers do this for you.

Acked-by: Alan Cox <alan@redhat.com>
