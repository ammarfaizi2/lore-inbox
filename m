Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946720AbWKJQD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946720AbWKJQD3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946721AbWKJQD2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:03:28 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53904 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1946720AbWKJQD2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:03:28 -0500
Message-ID: <4554A2F9.37B0023E@redhat.com>
Date: Fri, 10 Nov 2006 11:04:09 -0500
From: Dave Anderson <anderson@redhat.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-e.57enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Magnus Damm <magnus.damm@gmail.com>
CC: vgoyal@in.ibm.com, "Eric W. Biederman" <ebiederm@xmission.com>,
       Magnus Damm <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, fastboot@lists.osdl.org,
       Horms <horms@verge.net.au>
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
References: <20061102101942.452.73192.sendpatchset@localhost> <20061102101949.452.23441.sendpatchset@localhost> <m1psbwzpmx.fsf@ebiederm.dsl.xmission.com> <aec7e5c30611091952j6cd7988akc1671d269925bba9@mail.gmail.com> <m1irhnnb09.fsf@ebiederm.dsl.xmission.com> <aec7e5c30611092253q6bd15701x1f5da122de5c7075@mail.gmail.com> <20061110144922.GA8155@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > >Therefore we use 4 byte alignment unless it can be shown that the
> > >linux core dumps are a fluke and should be fixed.
> >
> > Ok. Vivek, Dave, anyone? Comments?
> >
>
> IMHO, I think we should go by the specs (8byte boundary alignment on 64bit
> platforms) until and unless it can be proven that specs are wrong. This
> probably will mean that we will break things for sometime (until and unless
> it is fixed in tool chain and probably will also break the capability to use
> an older kernel for capturing dump). But that's unavoidable if we want to be
> compliant to specs.
>
> Thanks
> Vivek

IMHO, why break things if it's not necessary?  As I understand it, you can
still take the course of least resistance and implement 64-bit xen/kdump
vmcores with 4-byte alignment -- and everybody's happy, right?

Unlike other tools that could potentially be broken, the crash utility will have
to maintain backwards compatibility for all the other 4-byte aligned 64-bit
vmcores out there.  So to me, it's more a PITA than anything else, and
I'll just adapt it to whatever's out there...

Thanks,
  Dave



