Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283043AbRLDKrW>; Tue, 4 Dec 2001 05:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283045AbRLDKrC>; Tue, 4 Dec 2001 05:47:02 -0500
Received: from zeus.kernel.org ([204.152.189.113]:1929 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S283043AbRLDKqw>;
	Tue, 4 Dec 2001 05:46:52 -0500
Date: Tue, 4 Dec 2001 10:40:47 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Christoph Rohland <cr@sap.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Maciej Zenczykowski <maze@druid.if.uj.edu.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Wrapping memory.
Message-ID: <20011204104047.A18147@flint.arm.linux.org.uk>
In-Reply-To: <m3r8qcagt7.fsf@linux.local> <E16AIZ8-0008Re-00@the-village.bc.nu> <12969.1007315617@redhat.com> <m3r8qcagt7.fsf@linux.local> <25163.1007370678@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <25163.1007370678@redhat.com>; from dwmw2@infradead.org on Mon, Dec 03, 2001 at 09:11:18AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2001 at 09:11:18AM +0000, David Woodhouse wrote:
> ARM used to just break, but I pointed it out to Russell a while ago and I 
> believe he fixed it. I don't remember what his fix was - it may have been 
> just to map the offending page uncached, which is also a fairly effective 
> was of avoiding cache aliasing :)

We actually still map the pages as cached, but when update_mmu_cache
detects that a page has been mmapped more than once, we ensure that
the other mappings in the current mm will fault when accessed.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

