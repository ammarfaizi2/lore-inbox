Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132111AbRAXSqj>; Wed, 24 Jan 2001 13:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132380AbRAXSqa>; Wed, 24 Jan 2001 13:46:30 -0500
Received: from cmn2.cmn.net ([206.168.145.10]:5450 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S131978AbRAXSqN>;
	Wed, 24 Jan 2001 13:46:13 -0500
Message-ID: <3A6F22D7.3000709@valinux.com>
Date: Wed, 24 Jan 2001 11:45:43 -0700
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.12-20smp i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: Timur Tabi <ttabi@interactivesi.com>
CC: Linux Kernel Mailing list <linux-kernel@vger.kernel.org>,
        Linux MM mailing list <linux-mm@kvack.org>
Subject: Re: Page Attribute Table (PAT) support?
In-Reply-To: <20010124174824Z129401-18594+948@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timur Tabi wrote:

> The Page Attribute Table (PAT) is an extension to the x86 page table format
> that lets you enable Write Combining on a per-page basis.  Details can be found
> in chapter 9.13 of the Intel Architecture Software Developer's Manual, Volume 3
> (System Programming).
> 
> I noticed that 2.4 doesn't support the Page Attribute Table, despite the fact
> that it has a X86_FEATURE_PAT macro in processor.h.  Are there any plans to add
> this support?  Ideally, I'd like it to be as a parameter for ioremap.

I'm actually writing support for the PAT as we speak.  I already have 
working code for PAT setup.  Just having a parameter for ioremap is not 
enough, unfortunately.  According to the Intel Architecture Software 
Developer's Manual we have to remove all mappings of the page that are 
cached.  Only then can they be mapped with per page write combining.  I 
should have working code by the 2.5.x timeframe.  I can also discuss the 
planned interface if anyone is interested.

-Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
