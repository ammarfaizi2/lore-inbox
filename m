Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTJ0L70 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 06:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbTJ0L7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 06:59:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5392 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261601AbTJ0L7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 06:59:23 -0500
Date: Mon, 27 Oct 2003 11:58:47 +0000
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Luck, Tony" <tony.luck@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       marcelo@conectiva.com.br
Subject: Re: [PATCH 2.4.23-pre8]  Remove broken prefetching in free_one_pgd()
Message-ID: <20031027115847.GA27230@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, "Luck, Tony" <tony.luck@intel.com>,
	Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-ia64@vger.kernel.org,
	linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F36E6@scsmsx401.sc.intel.com> <20031025201010.GC505@elf.ucw.cz> <20031026145156.GB28572@redhat.com> <20031027095259.GA312@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031027095259.GA312@elf.ucw.cz>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 27, 2003 at 10:52:59AM +0100, Pavel Machek wrote:

 > > It isn't on some CPUs.  Early athlons go bang when you prefetch
 > > past the end of RAM into unmapped memory for eg.
 > 
 > Well, broken HW :-(

There's a lot of it out there. If we didn't try to work around
some of it, we'd end up running on less < 10% of machines out there 8-)

> but andi's patch should fix up for that.

Different bug.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
