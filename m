Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUFBUao@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUFBUao (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 16:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264096AbUFBU3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 16:29:16 -0400
Received: from palrel12.hp.com ([156.153.255.237]:56523 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S264098AbUFBU1N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 16:27:13 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16574.14357.123292.702881@napali.hpl.hp.com>
Date: Wed, 2 Jun 2004 13:27:01 -0700
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com,
       <James.Bottomley@SteelEye.com>, <ak@suse.de>, <rmk@arm.linux.org.uk>,
       <paulus@samba.org>, <anton@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pretest pte_young and pte_dirty
In-Reply-To: <Pine.LNX.4.44.0406022114110.27696-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0406022103500.27696-100000@localhost.localdomain>
	<Pine.LNX.4.44.0406022114110.27696-100000@localhost.localdomain>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 2 Jun 2004 21:16:59 +0100 (BST), Hugh Dickins <hugh@veritas.com> said:

  Hugh> Test for pte_young before going to the costlier atomic
  Hugh> test_and_clear, as asm-generic does.  Test for pte_dirty
  Hugh> before going to the costlier atomic test_and_clear, as
  Hugh> asm-generic does (I said before that I would not do so for
  Hugh> pte_dirty, but was missing the point: there is nothing atomic
  Hugh> about deciding to do nothing).  But I've not touched the
  Hugh> rather different ppc and ppc64.

The ia64-portion of the patch looks good to me.

Thanks!

	--david
