Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261264AbSJHOho>; Tue, 8 Oct 2002 10:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261284AbSJHOho>; Tue, 8 Oct 2002 10:37:44 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37692 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261264AbSJHOhk>; Tue, 8 Oct 2002 10:37:40 -0400
Date: Tue, 8 Oct 2002 10:42:40 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200210081442.g98EgeH11258@devserv.devel.redhat.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: kbuild news
In-Reply-To: <mailman.1034070360.25457.linux-kernel2news@redhat.com>
References: <mailman.1034070360.25457.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Keith Owens <kaos@ocs.com.au>

>>No, the kallsyms object file would not need to be seen by
>>the btfixup.o generator.  It could therefore be done validly
>>as:
>>
>>	1) build .tmp_vmlinux
>>	2) build btfixup.o
>>	3) build kallsyms
>>	4) link final vmlinux image
>>
>>The order of #2 and #3 could be transposed and that would be fine too.
> 
> Wrong.  Anything that changes the address or size of any symbol or
> section invalidates the kallsyms data.  kallsyms must be run on the
> definitive vmlinux contents, with everything else already included and
> all sizes must be stable.

Let's face it, both btfixup and kallsyms "want" to be the last,
so something has to give.

-- Pete
