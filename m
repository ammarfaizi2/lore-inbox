Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310749AbSDIXf7>; Tue, 9 Apr 2002 19:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310806AbSDIXf6>; Tue, 9 Apr 2002 19:35:58 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:26432 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310749AbSDIXfy>; Tue, 9 Apr 2002 19:35:54 -0400
Date: Wed, 10 Apr 2002 01:36:09 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Aviv Shavit <avivshavit@yahoo.com>
Cc: Ken Brownfield <brownfld@irridia.com>, linux-kernel@vger.kernel.org
Subject: vm-33, strongly recommended [Re: [2.4.17/18pre] VM and swap - it's really unusable]
Message-ID: <20020410013609.A6875@dualathlon.random>
In-Reply-To: <20020225224050.D26077@asooo.flowerfire.com> <20020409204545.11251.qmail@web13205.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recommend everybody to never use a 2.4 kernel without first applying
this vm patch:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre5/vm-33.gz

It applies cleanly to both 2.4.19pre5 and 2.4.19pre6. Andrew splitted it
into orthogonal pieces for easy merging from Marcelo's side (modulo
-rest that is important too but that it's still quite monolithic, but
it's pointless to invest further effort at this time until we are
certain Marcelo will do its job and eventually merge it in mainline):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.19pre5/

So far a first part of those patches is been merged into mainline into
pre5 (not any previous kernel, if you've some problem reproducible with
pre4 pre3 pre2 and pre1 or any previous kernel that's not related to the
async flushing changes, I seen a bogus report floating around to Marcelo
about pre1 pointing to the vm changes, it can't be the vm changes if
it's pre[1234]).

This VM is under heavy stressing for weeks on my SMP highmem machine
with a real life DBMS workload in a real life setup with huge VM
pressure with mem=1024m and 1.2G of shm pushed in swap constantly by the
kernel, performance of the workload is now very good and exactly
reproducible and constant, so I recommend it for all production systems
(both lowmem desktops and highend servers).

Alternatively you can use the whole -aa patchkit, to get all the other
critical highend features like pte-highmem, highio etc...

I haven't bugreports pending on the vm patch.

Thanks,

Andrea
