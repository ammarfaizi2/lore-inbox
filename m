Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVCOS0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVCOS0B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVCOSYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:24:36 -0500
Received: from [195.23.16.24] ([195.23.16.24]:31434 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261701AbVCOSWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:22:18 -0500
Message-ID: <423727BD.7080200@grupopie.com>
Date: Tue, 15 Mar 2005 18:21:49 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2/2] SquashFS
References: <20050314170653.1ed105eb.akpm@osdl.org>	<A572579D-94EF-11D9-8833-000A956F5A02@lougher.demon.co.uk> <20050314190140.5496221b.akpm@osdl.org>
In-Reply-To: <20050314190140.5496221b.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> [...]
> Also, this filesystem seems to do the same thing as cramfs.  We'd need to
> understand in some detail what advantages squashfs has over cramfs to
> justify merging it.  Again, that is something which is appropriate to the
> changelog for patch 1/1.

Well, probably Phillip can answer this better than me, but the main 
differences that affect end users (and that is why we are using SquashFS 
right now) are:
                           CRAMFS          SquashFS

Max File Size               16Mb               4Gb
Max Filesystem Size        256Mb              4Gb?
UID/GID                   8 bits           32 bits
Block Size                    4K       default 64k

Probably the block size is the most responsible for this, but the 
compression ratio achieved by SquashFS is much higher than that achieved 
with cramfs.

I just wanted to say one thing on behalf of SquashFS. We've been using 
SquashFS in production on a POS system we sell, and we have currently 
more than 1200 of these in use. There was never a problem reported that 
involved SquashFS.

Although the workload patterns of these systems are probably very 
similar (so the quantity doesn't really matter much), it is a real world 
test of the filesystem, nevertheless.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
