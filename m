Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264297AbUDNRna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 13:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264294AbUDNRn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 13:43:29 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:54255 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S264297AbUDNRn2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 13:43:28 -0400
Subject: Re: [Ext2-devel] Re: [RFC] extents,delayed allocation,mballoc for
	ext3
From: Mingming Cao <cmm@us.ibm.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <m3ekqqoj3m.fsf@bzzz.home.net>
References: <m365c3pthi.fsf@bzzz.home.net>  <m3ekqqoj3m.fsf@bzzz.home.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Apr 2004 10:49:59 -0700
Message-Id: <1081965005.15980.6906.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-14 at 05:10, Alex Tomas wrote:
> 
> I've just benched ext3 vs. ext3+reservation vs. ext3+delalloc vs. xfs.
> it was tiobench.
> ext3                          1024  4096   32    8.12 9.872%     8.111    82
> ext3-dalloc                   1024  4096   32   24.83 20.01%     2.995   124
> ext3-reserv                   1024  4096   32   22.72 29.51%     3.282    77
> xfs                           1024  4096   32   25.47 21.75%     2.247   117
> 
Hi Alex,

Nice comparison! The ext3 reservation system use more cpus because we do
reservations in memory( not on disk) and we have a global lock per
filesystem to guard the operation.  The current search for a new
reservation window algorithm is not perfect right now.  

extents and delayed allocation probably is the right way to go for next
generation (maybe ext4).  Currently I just try to fix the missing
preallocation feature in ext3, without break the disk compatibility and
involve too much changes....

Thanks for your interest.

Mingming

