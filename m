Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbTCENBE>; Wed, 5 Mar 2003 08:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266233AbTCENBD>; Wed, 5 Mar 2003 08:01:03 -0500
Received: from holomorphy.com ([66.224.33.161]:35741 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266224AbTCENA7>;
	Wed, 5 Mar 2003 08:00:59 -0500
Date: Wed, 5 Mar 2003 05:10:56 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Michael Vergoz <mvergoz@sysdoor.com>
Cc: alan@lxorguk.ukuu.org.uk, timothy.a.reed@lmco.com,
       linux-kernel@vger.kernel.org
Subject: Re: High Mem Options
Message-ID: <20030305131056.GT1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Michael Vergoz <mvergoz@sysdoor.com>, alan@lxorguk.ukuu.org.uk,
	timothy.a.reed@lmco.com, linux-kernel@vger.kernel.org
References: <9EFD49E2FB59D411AABA0008C7E675C00DCDFE01@emss04m10.ems.lmco.com> <20030305131116.0556f3a5.mvergoz@sysdoor.com> <1046871362.14169.0.camel@irongate.swansea.linux.org.uk> <20030305134937.5414b913.mvergoz@sysdoor.com> <20030305125747.GS1195@holomorphy.com> <20030305140257.2ab08ab8.mvergoz@sysdoor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305140257.2ab08ab8.mvergoz@sysdoor.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Mar 2003 04:57:47 -0800, William Lee Irwin III wrote:
>> The cpu can't look at more than 4GB at a time.
>> Protected mode doesn't help this, turning paging on and PAE on does.
>> What it can do is point pagetables at different 4GB subsets of memory.
>> c.f. kmap_atomic() for how to window around using what's actually a
>> very small set of PTE's.

On Wed, Mar 05, 2003 at 02:02:57PM +0100, Michael Vergoz wrote:
> Right, but if the pagetable pointing to a different 4GB subsets of
> memory. The performance of the system can be disastrous, not?

Well, the TLB gets blown away at the drop of a hat. Things just have
lower scaling factors with respect to memory than say, 64-bit, though
Linux doesn't do anything about TLB coverage on 64-bit yet anyway.

It might be better to take this one to kernelnewbies@nl.linux.org


-- wli
