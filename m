Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWFGMNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWFGMNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 08:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbWFGMNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 08:13:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:481 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932227AbWFGMNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 08:13:16 -0400
From: Andi Kleen <ak@suse.de>
To: Keith Owens <kaos@sgi.com>
Subject: Re: NMI problems with Dell SMP Xeons
Date: Wed, 7 Jun 2006 14:13:00 +0200
User-Agent: KMail/1.9.3
Cc: Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org,
       "Brendan Trotter" <btrotter@gmail.com>
References: <6799.1149680860@ocs3.ocs.com.au>
In-Reply-To: <6799.1149680860@ocs3.ocs.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606071413.00990.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 June 2006 13:47, Keith Owens wrote:
> Andi Kleen (on Wed, 7 Jun 2006 10:01:40 +0200) wrote:
> >
> >>
> >> Two ways:
> >>
> >> (1) Boot with a kernel with CONFIG_ACPI=n, so the OS only finds 2 cpus
> >>     in the MPT instead of the 4 listed by ACPI.
> >>
> >> (2) The kernel has ACPI=y, but is booted with maxcpus=2.
> >>
> >> In both cases, send_IPI_allbutself() with IPI 2 or an NMI will result
> >> in a hard reset.
> >
> >Sounds both like a "Don't do that when it hurts" . I know some people
> >have religious issues with ACPI, but it's simple a fact that many
> >modern boxes don't work correctly in obvious or subtle ways without it. 
> 
> Building a kernel without ACPI is silly nowadays.  But even with ACPI,
> booting with a restricted maxcpus and sending IPI 2 or NMI as broadcast
> will kill these boxes.  maxcpus is a valid option.

Yes, I'm not opposed to using *_sequence on cpu_online_map here. Please send a patch.

-Andi
