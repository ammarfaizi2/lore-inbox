Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286603AbRL0UZP>; Thu, 27 Dec 2001 15:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbRL0UZH>; Thu, 27 Dec 2001 15:25:07 -0500
Received: from h55p103-3.delphi.afb.lu.se ([130.235.187.176]:61860 "EHLO gin")
	by vger.kernel.org with ESMTP id <S286638AbRL0UY5>;
	Thu, 27 Dec 2001 15:24:57 -0500
Date: Thu, 27 Dec 2001 21:24:51 +0100
To: Andrew Morton <akpm@zip.com.au>
Cc: andersg@0x63.nu, linux-kernel@vger.kernel.org, lvm-devel@sistina.com
Subject: Re: lvm in 2.5.1
Message-ID: <20011227202451.GC20501@h55p111.delphi.afb.lu.se>
In-Reply-To: <20011227084304.GA26255@h55p111.delphi.afb.lu.se> <3C2AEADB.24BEFE94@zip.com.au> <20011227122520.GA2194@h55p111.delphi.afb.lu.se> <3C2B75B3.4DEF90D3@zip.com.au> <20011227193711.GB20501@h55p111.delphi.afb.lu.se> <3C2B7A3E.E5C05404@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C2B7A3E.E5C05404@zip.com.au>
User-Agent: Mutt/1.3.24i
From: andersg@0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 11:45:02AM -0800, Andrew Morton wrote:

> Ah.  Right you are.  I was looking at the 2.4.17 source.  That array
> was added in 2.5.x.
> 
> So 2.4.x is OK.

this means the userspace and kernelspace lv_t differ in size.. so a
copy_to_user(..,sizeof(lv_t)) copies to much data and corrupts userspace..

hmm, enlarging the dummy[200] in the userspace version of lv_t seems to be a
nice quickndirty solution.

-- 

//anders/g

