Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbTCEMwz>; Wed, 5 Mar 2003 07:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbTCEMwz>; Wed, 5 Mar 2003 07:52:55 -0500
Received: from sysdoor.net ([62.212.103.239]:17420 "EHLO celia")
	by vger.kernel.org with ESMTP id <S266368AbTCEMww>;
	Wed, 5 Mar 2003 07:52:52 -0500
Date: Wed, 5 Mar 2003 14:02:57 +0100
From: Michael Vergoz <mvergoz@sysdoor.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: alan@lxorguk.ukuu.org.uk, timothy.a.reed@lmco.com,
       linux-kernel@vger.kernel.org
Subject: Re: High Mem Options
Message-Id: <20030305140257.2ab08ab8.mvergoz@sysdoor.com>
In-Reply-To: <20030305125747.GS1195@holomorphy.com>
References: <9EFD49E2FB59D411AABA0008C7E675C00DCDFE01@emss04m10.ems.lmco.com>
	<20030305131116.0556f3a5.mvergoz@sysdoor.com>
	<1046871362.14169.0.camel@irongate.swansea.linux.org.uk>
	<20030305134937.5414b913.mvergoz@sysdoor.com>
	<20030305125747.GS1195@holomorphy.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

Right, but if the pagetable pointing to a different 4GB subsets of memory.
The performance of the system can be disastrous, not?

Best regards,
Michael

On Wed, 5 Mar 2003 04:57:47 -0800
William Lee Irwin III <wli@holomorphy.com> wrote:

> On Wed, Mar 05, 2003 at 01:49:37PM +0100, Michael Vergoz wrote:
> > That i can't understand i when the system going to the protect mode. 
> > How the system can use over 4GB memory ?
> > On freebsd, when you have over 4GB the system say "XGB of XGB skiped..."
> > (i'v got a machine with 8GB running on freebsd and without memory spare)
> 
> The cpu can't look at more than 4GB at a time.
> 
> Protected mode doesn't help this, turning paging on and PAE on does.
> 
> What it can do is point pagetables at different 4GB subsets of memory.
> 
> c.f. kmap_atomic() for how to window around using what's actually a
> very small set of PTE's.
> 
> 
> -- wli
