Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbTCEMr7>; Wed, 5 Mar 2003 07:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbTCEMr7>; Wed, 5 Mar 2003 07:47:59 -0500
Received: from holomorphy.com ([66.224.33.161]:30621 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264729AbTCEMr6>;
	Wed, 5 Mar 2003 07:47:58 -0500
Date: Wed, 5 Mar 2003 04:57:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Michael Vergoz <mvergoz@sysdoor.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, timothy.a.reed@lmco.com,
       linux-kernel@vger.kernel.org
Subject: Re: High Mem Options
Message-ID: <20030305125747.GS1195@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Michael Vergoz <mvergoz@sysdoor.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, timothy.a.reed@lmco.com,
	linux-kernel@vger.kernel.org
References: <9EFD49E2FB59D411AABA0008C7E675C00DCDFE01@emss04m10.ems.lmco.com> <20030305131116.0556f3a5.mvergoz@sysdoor.com> <1046871362.14169.0.camel@irongate.swansea.linux.org.uk> <20030305134937.5414b913.mvergoz@sysdoor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305134937.5414b913.mvergoz@sysdoor.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 01:49:37PM +0100, Michael Vergoz wrote:
> That i can't understand i when the system going to the protect mode. 
> How the system can use over 4GB memory ?
> On freebsd, when you have over 4GB the system say "XGB of XGB skiped..."
> (i'v got a machine with 8GB running on freebsd and without memory spare)

The cpu can't look at more than 4GB at a time.

Protected mode doesn't help this, turning paging on and PAE on does.

What it can do is point pagetables at different 4GB subsets of memory.

c.f. kmap_atomic() for how to window around using what's actually a
very small set of PTE's.


-- wli
