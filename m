Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262673AbTJXWBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 18:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTJXWBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 18:01:07 -0400
Received: from palrel10.hp.com ([156.153.255.245]:31394 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S262673AbTJXWBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 18:01:04 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16281.41246.100100.205167@napali.hpl.hp.com>
Date: Fri, 24 Oct 2003 15:01:02 -0700
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <marcelo@conectiva.com.br>
Subject: Re: [PATCH 2.4.23-pre8]  Remove broken prefetching in free_one_pgd()
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0F36E6@scsmsx401.sc.intel.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F36E6@scsmsx401.sc.intel.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 24 Oct 2003 13:56:31 -0700, "Luck, Tony" <tony.luck@intel.com> said:

  Tony> This patch was accepted into 2.5.55, attributed to "davej@uk".
  Tony> This code will prefetch from beyond the end of the page table
  Tony> being cleared ... which is clearly a bad thing if the page
  Tony> table in question is allocated from the last page of memory
  Tony> (or precedes a hole on a discontig mem system).

Different arches behave differently, though.  In the case of ia64,
it'a always safe to prefetch (even with lfetch.fault).

	--david
