Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTJ0Jxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 04:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbTJ0Jxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 04:53:35 -0500
Received: from gprs196-26.eurotel.cz ([160.218.196.26]:60032 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261298AbTJ0JxN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 04:53:13 -0500
Date: Mon, 27 Oct 2003 10:52:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dave Jones <davej@redhat.com>, "Luck, Tony" <tony.luck@intel.com>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: [PATCH 2.4.23-pre8]  Remove broken prefetching in free_one_pgd()
Message-ID: <20031027095259.GA312@elf.ucw.cz>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F36E6@scsmsx401.sc.intel.com> <20031025201010.GC505@elf.ucw.cz> <20031026145156.GB28572@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031026145156.GB28572@redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > This code will prefetch from beyond the end of the page table
>  > > being cleared ... which is clearly a bad thing if the page table
>  > > in question is allocated from the last page of memory (or precedes
>  > > a hole on a discontig mem system).
>  > Prefetching random addresses should be safe...
> 
> It isn't on some CPUs.  Early athlons go bang when you prefetch
> past the end of RAM into unmapped memory for eg.

Well, broken HW :-(, but andi's patch should fix up for that.

								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
