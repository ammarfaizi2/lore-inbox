Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWHGIjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWHGIjz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 04:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWHGIjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 04:39:55 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:62535 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751160AbWHGIjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 04:39:54 -0400
Subject: Re: [patch 20/23] S390: fix futex_atomic_cmpxchg_inatomic
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <20060804054038.GU769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
	 <20060804054038.GU769@kroah.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 07 Aug 2006 10:39:08 +0200
Message-Id: <1154939948.6721.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-03 at 22:40 -0700, Greg KH wrote:
> plain text document attachment
> (s390-fix-futex_atomic_cmpxchg_inatomic.patch)
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> [S390] fix futex_atomic_cmpxchg_inatomic
> 
> futex_atomic_cmpxchg_inatomic has the same bug as the other
> atomic futex operations: the operation needs to be done in the
> user address space, not the kernel address space. Add the missing
> sacf 256 & sacf 0.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 

Hi Greg,
sorry for the late answer. Stable version 2.6.17.8 contains the
necessary patches to fix the futex hole and I currently do not know of
any other critical bugs that need fixing. Thanks!

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


