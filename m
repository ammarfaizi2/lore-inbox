Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272945AbTHKSYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 14:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272919AbTHKSV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 14:21:58 -0400
Received: from palrel13.hp.com ([156.153.255.238]:60070 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S272840AbTHKSVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 14:21:32 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16183.56997.123977.527982@napali.hpl.hp.com>
Date: Mon, 11 Aug 2003 11:21:25 -0700
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
Cc: davem@redhat.com, jmorris@intercode.com.au, linux-kernel@vger.kernel.org
Subject: Re: virt_to_offset()
In-Reply-To: <20030810.180241.71795022.yoshfuji@linux-ipv6.org>
References: <20030810081529.GX31810@waste.org>
	<20030810.173215.102258218.yoshfuji@linux-ipv6.org>
	<20030810013041.679ddc4c.davem@redhat.com>
	<20030810.180241.71795022.yoshfuji@linux-ipv6.org>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Yoshifuji> In article <20030810013041.679ddc4c.davem@redhat.com> (at
  Yoshifuji> Sun, 10 Aug 2003 01:30:41 -0700), "David S. Miller"
  Yoshifuji> <davem@redhat.com> says:
  >> > BTW, we spread ((long) ptr & ~PAGE_MASK); it seems ugly.  > Why
  >> don't we have vert_to_offset(ptr) or something like this?  >
  >> #define virt_to_offset(ptr) ((unsigned long) (ptr) & ~PAGE_MASK)
  >> > Is this bad idea?

  >> With some name like "virt_to_pageoff()" it sounds like a great
  >> idea.

  Yoshifuji> Okay.  How about this?  (I'm going to do the actual
  Yoshifuji> conversion soon.)

It's a bad choice of name.  X_to_Y() normally implies that X and Y are
basically different representations of the same thing (e.g., a page
pointer vs. a virtual address).  However, virt_to_pageoff() is a
one-way translation, so it's misleading.  In my opinion, it should be
called page_offset() or something like that.

	--david
