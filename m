Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752138AbWFLTnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752138AbWFLTnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 15:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbWFLTnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 15:43:07 -0400
Received: from smtp-out.google.com ([216.239.45.12]:43169 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1752138AbWFLTnG (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 15:43:06 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=xTfs+lwI18TcoPJ/oPi29QGws6d78YixcuZXh+bkWq+VqExJDXYJ2f+X15zg9DCoV
	zMmUoLw6Aoa8qzR4vIEtg==
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number
	of	physical pages backing it
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Andi Kleen <ak@suse.de>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Linux-mm@kvack.org, Linux-kernel@vger.kernel.org
In-Reply-To: <200606121958.41127.ak@suse.de>
References: <1149903235.31417.84.camel@galaxy.corp.google.com>
	 <448A762F.7000105@yahoo.com.au>
	 <1150133795.9576.19.camel@galaxy.corp.google.com>
	 <200606121958.41127.ak@suse.de>
Content-Type: text/plain
Organization: Google Inc
Date: Mon, 12 Jun 2006 12:42:49 -0700
Message-Id: <1150141369.9576.43.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 19:58 +0200, Andi Kleen wrote:
> > It is just the price of those walks that makes smaps not an attractive
> > solution for monitoring purposes.
> 
> It just shouldn't be used for that. It's a debugging hack and not really 
> suitable for monitoring even with optimizations.
> 
> For monitoring if the current numa statistics are not good enough
> you should probably propose new counters.


numa stats are giving different data.  The proposed vma->nr_phys is the
new counter that can provide a detailed information about physical mem
usage at each virtual mem segment level.  I think having this
information in each vma keeps the impact (of adding new counter) to very
low.

Second question is to advertize this value to user space.  Please let me
know what suites the most among /proc, /sys or system call (or if there
is any other mechanism then let me know) for a per process per segment
related information.

-rohit



