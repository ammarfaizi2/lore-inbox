Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269224AbUINJIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269224AbUINJIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269227AbUINJIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:08:05 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:34261 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S269224AbUINJHO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:07:14 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16710.46269.961782.124751@thebsh.namesys.com>
Date: Tue, 14 Sep 2004 13:07:09 +0400
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm5
In-Reply-To: <200409132306.38340.rjw@sisk.pl>
References: <20040913015003.5406abae.akpm@osdl.org>
	<200409132306.38340.rjw@sisk.pl>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rafael J. Wysocki writes:
 > On Monday 13 of September 2004 10:50, Andrew Morton wrote:
 > > 
 > > Due to master.kernel.org being on the blink, 2.6.9-rc1-mm5 Is currently at
 > > 
 > >  http://www.zip.com.au/~akpm/linux/patches/2.6.9-rc1-mm5/
 > > 
 > > and will later appear at
 > > 
 > >  
 > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm5/
 > 
 > It does not compile on SMP x86-64 w/ NUMA:
 > 
 >   CC      arch/x86_64/ia32/ia32_ioctl.o
 > In file included from fs/compat_ioctl.c:63,
 >                  from arch/x86_64/ia32/ia32_ioctl.c:14:
 > include/linux/reiserfs_fs.h:441: error: redefinition of `struct key'
 > include/linux/reiserfs_fs.h: In function `le_key_k_offset':

include/linux/key.h defines struct key that conflicts with reiserfs'
struct key. As a temporary fix turn off CONFIG_KEYS (or
CONFIG_REISERFS_FS :)).

Correct solution is to put both structs into proper namespaces by
prefixing them.

 > Greets,
 > RJW
 > 

Nikita.

