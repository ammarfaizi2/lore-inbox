Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284596AbRLJXNH>; Mon, 10 Dec 2001 18:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284599AbRLJXNB>; Mon, 10 Dec 2001 18:13:01 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:35723 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S284596AbRLJXMu>; Mon, 10 Dec 2001 18:12:50 -0500
Message-Id: <200112102312.fBANCcq03225@butler1.beaverton.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux (NUMA)
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.17-pre5
Date: Mon, 10 Dec 2001 15:12:38 -0800
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E16DLo2-0001CL-00@the-village.bc.nu>
In-Reply-To: <E16DLo2-0001CL-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 December 2001 12:28 am, Alan Cox wrote:
> > Agreed, but does the current x86 code does map them like this or not?
> > If it does, I'm curious as to why they saw a problem which this fixed.
>
> The current x86 code maps the logical cpus as with the physical ones. In
> other words its how they come off the mainboard. Which for HT seems to
> be with each HT as (n, n+1)

Yes.  Intel has defined the LSB of the physical APIC ID to be the 
"hyperthreading" bit.  Even numbered IDs are real CPUs; odd IDs are the 
virtual CPUs.  (Or, as wli calls them, Schwarzenegger and Di Vito. ;^)

This may complicate Rusty's zen scheduler scheme.  It certainly has made life 
complicated for the BIOS folks.  They had to sort all the real CPUs to the 
front of the ACPI table, lest those folks so benighted as to run the crippled 
version of Win2K (which only on-lines 8 CPUs) only get four real CPUs out of 
eight.

Anyway, with Intel's new numbering scheme you only get two real CPUs per 
logical cluster of 4, which is kind of a pain....

> > understand what is happening.  I posted my findings, and I'd really
> > like to get some feedback from others doing the same thing.

[ Snip! ]

>
> Alan


-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesclv@us.ibm.com   |   cleverdj@us.ibm.com

