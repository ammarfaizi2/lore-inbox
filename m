Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268938AbTGJFky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 01:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268939AbTGJFky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 01:40:54 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:36931 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S268938AbTGJFkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 01:40:53 -0400
Date: Thu, 10 Jul 2003 01:55:26 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200307100555.h6A5tQV21673@devserv.devel.redhat.com>
To: Werner Almesberger <wa@almesberger.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: crypto API and IBM z990 hardware support
In-Reply-To: <mailman.1057799700.15422.linux-kernel2news@redhat.com>
References: <OF1BACB1D3.F4409038-ONC1256D57.00247A0A-C1256D57.002701D8@de.ibm.com> <Mutt.LNX.4.44.0307021913540.31308-100000@excalibur.intercode.com.au> <20030707080929.A1848@infradead.org> <20030707.195350.39170946.davem@redhat.com> <mailman.1057799700.15422.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I totally disagree.  I think the way we do things today is _STUPID_.
>> We put arch code far away from the generic version which makes finding
>> stuff very difficult for people inspecting the code for the first time.
>> 
>> For example, the fact that I have to go groveling in
>> arch/foo/lib/whoknowswhatfile.whoknowswhatextension to look at
>> the memcpy/checksum/whatever implementation is completely busted.

> E.g. most of include/net/tcp.h pretty much only matters for
> net/ipv4/. It would be so nice if a  grep -w thing *.[ch]  in
> net/ipv4/ would really find all uses of "thing".

I always do this:

cd linux
find . \( -name 'Make*' -o -name '*.[hcS]' \) > src.list
cat src.list| LANG=C xargs grep foo

It's only a CPU time, really.

-- Pete
