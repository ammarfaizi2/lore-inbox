Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbVJQTJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbVJQTJg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 15:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVJQTJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 15:09:36 -0400
Received: from mx1.suse.de ([195.135.220.2]:29400 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932287AbVJQTJf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 15:09:35 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
Date: Mon, 17 Oct 2005 21:09:52 +0200
User-Agent: KMail/1.8
Cc: Muli Ben-Yehuda <mulix@mulix.org>, discuss@x86-64.org,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, shai@scalex86.org, clameter@engr.sgi.com,
       muli@il.ibm.com, jdmason@us.ibm.com
References: <20051017093654.GA7652@localhost.localdomain> <20051017184523.GB26239@granada.merseine.nu> <Pine.LNX.4.64.0510171200490.3369@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510171200490.3369@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510172109.54066.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 21:04, Linus Torvalds wrote:

> So the only thing that worried me (and made me ask whether there might be
> machines where it doesn't work) is if some machines might have their high
> memory (or no memory at all) on NODE(0). It does sound unlikely, but I
> simple don't know what kind of strange NUMA configs there are out there.

It could happen in VirtualIron (they seem to interleave node 0 over many nodes 
to get equal use of lowmem in 32bit NUMA), but should not in x86-64..
 
> And I'm definitely only interested in machines that are out there, not
> some theoretical issues.

According to Alex W. it will break their sx1000 IA64 boxen.

-Andi (who still thinks it's best to just ignore it or disable Intel NUMA) 
