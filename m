Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265447AbSJXOYk>; Thu, 24 Oct 2002 10:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265449AbSJXOYi>; Thu, 24 Oct 2002 10:24:38 -0400
Received: from franka.aracnet.com ([216.99.193.44]:37543 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265447AbSJXOYh>; Thu, 24 Oct 2002 10:24:37 -0400
Date: Thu, 24 Oct 2002 07:28:32 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ed Tomlinson <tomlins@cam.org>, Andrew Morton <akpm@digeo.com>
cc: Rik van Riel <riel@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
Message-ID: <2833019656.1035444511@[10.10.2.3]>
In-Reply-To: <200210240735.48973.tomlins@cam.org>
References: <200210240735.48973.tomlins@cam.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just experienced this problem on UP with 513M memory.  About 400m was 
> locked in dentries.  The system was very unresponsive - suspect it was
> spending gobs of time scaning unfreeable dentries.  This was with -mm3
> up about 24 hours.
> 
> The inode caches looked sane.  Just the dentries were out of wack.

I think you want this:

+read-barrier-depends.patch
 RCU fix

Which is only in mm4 I believe. Wanna retest? mm4 is the first 44-mmX
that works for me ... seems to have quite a few bugfixes ;-)

M.

