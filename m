Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287366AbSACV7N>; Thu, 3 Jan 2002 16:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287372AbSACV7C>; Thu, 3 Jan 2002 16:59:02 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:36618 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287368AbSACV6s>; Thu, 3 Jan 2002 16:58:48 -0500
Message-ID: <3C34D306.F0893D1B@zip.com.au>
Date: Thu, 03 Jan 2002 13:54:14 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ken Brownfield <brownfld@irridia.com>
CC: Andreas Hartmann <andihartmann@freenet.de>,
        Kernel-Mailingliste <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <3C2CD326.100@athlon.maya.org>,
		<3C2CD326.100@athlon.maya.org>; from andihartmann@freenet.de on Fri, Dec 28, 2001 at 09:16:38PM +0100 <20020103142301.C4759@asooo.flowerfire.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Brownfield wrote:
> 
> Unfortunately, I lost the response that basically said "2.4 looks stable
> to me", but let me count the ways in which I agree with Andreas'
> sentiment:
> 
>         A) VM has major issues
>                 1) about a dozen recent OOPS reports in VM code

Ben LaHaise's fix for page_cache_release() is absolutely required.

>                 2) VM falls down on large-memory machines with a
>                    high inode count (slocate/updatedb, i/dcache)
>                 3) Memory allocation failures and OOM triggers
>                    even though caches remain full.
>                 4) Other bugs fixed in -aa and others
>         B) Live- and dead-locks that I'm seeing on all 2.4 production
>            machines > 2.4.9, possibly related to A.  But how will I
>            ever find out?

Does this happen with the latest -aa patch?  If so, please send
a full system description and report.

>         C) IO-APIC code that requires noapic on any and all SMP
>            machines that I've ever run on.

Dunno about this one.  Have you prepared a description?
 

-
