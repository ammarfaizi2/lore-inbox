Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262653AbVAKJyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbVAKJyf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 04:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVAKJyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 04:54:35 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:56292 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262653AbVAKJyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 04:54:32 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Phy Prabab <phyprabab@yahoo.com>
Date: Tue, 11 Jan 2005 20:54:20 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16867.41549.618.539945@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux NFS vs NetApp
In-Reply-To: message from Phy Prabab on Monday January 10
References: <20050111025401.48311.qmail@web51810.mail.yahoo.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday January 10, phyprabab@yahoo.com wrote:
> Hello!
> 
> I am trying to understand how NetApp can be so much
> better at NFS servicing than my quad Opteron 250 SAN
> attached machine.  So I need some help and some
> pointers to understand how I can make my opteron
> machine come on par (or within 70% NFS performance
> range) as that of my NetApp R200.  I have run through
> the NFS-how-to's and have heard "that is why they cost
> so much more", but I really have to consider that
> probably most of the ideas that are in the NetApp are
> common knowldge (just not in my head).
> 
> Can anyone shed some light on this?

If you want to come anything close to comparable with a Netapp, get a
few hundred Megabytes of NVRAM (e.g. www.umem.com), and configure it
as an external journal for your filesystem (I know this can be done
for ext3, I don't know about other filesystems).  Then make sure your
filesystem journals all data, not just metadata (data=journal option
to ext3).

If you use a dedicated drive (or mirrored pair) in place of the NVRAM,
you will come reasonably close.

NeilBrown
