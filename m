Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267845AbTBVIAn>; Sat, 22 Feb 2003 03:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267844AbTBVIAm>; Sat, 22 Feb 2003 03:00:42 -0500
Received: from franka.aracnet.com ([216.99.193.44]:35247 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267845AbTBVIAl>; Sat, 22 Feb 2003 03:00:41 -0500
Date: Sat, 22 Feb 2003 00:10:46 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Strange performance change 59 -> 61/62
Message-ID: <25510000.1045901445@[10.10.2.4]>
In-Reply-To: <20030222000410.11a46e03.akpm@digeo.com>
References: <32720000.1045671824@[10.10.2.4]><20030219101957.05088aa1.akpm@digeo.com><17280000.1045811967@[10.10.2.4]><17930000.1045812486@[10.10.2.4]><20030220234522.185f3f6c.akpm@digeo.com><11870000.1045848448@[10.10.2.4]><20030221122024.040055a0.akpm@digeo.com><22560000.1045899976@[10.10.2.4]> <20030222000410.11a46e03.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK.  We used to only run mark_inode_dirty() for atime updates just when it
> had actually changed.  ie: once per second.  But for reasons which remain
> obscure that was taken out.
> 
> This probably explains your ext3 woes.  Poor old ext3 has to do a ton of work
> in ext3_mark_inode_dirty(), yet on 99% of the calls, nothing has even
> changed.  Which is why I suggested that you retest ext3 with noatime.

Shall do - tommorow ;-)
 
> I shall fix it up.

Sounds great - thank you,

M.

