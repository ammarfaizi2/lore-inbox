Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbTJZOwV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 09:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbTJZOwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 09:52:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22790 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263185AbTJZOwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 09:52:19 -0500
Date: Sun, 26 Oct 2003 14:51:56 +0000
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Luck, Tony" <tony.luck@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: [PATCH 2.4.23-pre8]  Remove broken prefetching in free_one_pgd()
Message-ID: <20031026145156.GB28572@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, "Luck, Tony" <tony.luck@intel.com>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F36E6@scsmsx401.sc.intel.com> <20031025201010.GC505@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031025201010.GC505@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 25, 2003 at 10:10:10PM +0200, Pavel Machek wrote:

 > > This patch was accepted into 2.5.55, attributed to "davej@uk".
 > Dave Jones?n

Yep.

 > > This code will prefetch from beyond the end of the page table
 > > being cleared ... which is clearly a bad thing if the page table
 > > in question is allocated from the last page of memory (or precedes
 > > a hole on a discontig mem system).
 > Prefetching random addresses should be safe...

It isn't on some CPUs.  Early athlons go bang when you prefetch
past the end of RAM into unmapped memory for eg.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
