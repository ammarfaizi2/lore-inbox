Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266281AbUHBS1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266281AbUHBS1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 14:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUHBS1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 14:27:37 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:33769 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S266281AbUHBS1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 14:27:36 -0400
Message-ID: <410E8794.2030900@tungstengraphics.com>
Date: Mon, 02 Aug 2004 19:27:32 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Romanick <idr@us.ibm.com>
Cc: Jon Smirl <jonsmirl@yahoo.com>, lkml <linux-kernel@vger.kernel.org>,
       Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>
Subject: Re: DRM code reorganization
References: <20040802155312.56128.qmail@web14923.mail.yahoo.com> <410E81C3.2070804@us.ibm.com>
In-Reply-To: <410E81C3.2070804@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> ian: what about splitting the current memory management code into a
>> module that can be swapped for your new version?
> 
> 
> AFAIK, the only drivers that have any sort of in-kernel memory manager 
> are the radeon (only used by the R200 driver) and i830.  That memory 
> manager only exists to support an NV_vertex_array_range-like extension 
> that some Tungsten customers needed.  I don't think there would be any 
> benefit to making that swappable.
> 
> Once the new memory manager is in, 80% (or more) of the code will be in 
> user-mode anyway.  The code that will be in the kernel should be generic 
> enough to be completely sharable (i.e., in a generic DRM library).

Yes, the future is Ian's manager.  The existing ones are built to be discarded 
when something better comes along.

Keith

