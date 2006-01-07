Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030568AbWAGTpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030568AbWAGTpb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030567AbWAGTpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:45:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65237 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030568AbWAGTpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:45:30 -0500
To: yhlu <yhlu.kernel@gmail.com>
Cc: Andi Kleen <ak@muc.de>, Vivek Goyal <vgoyal@in.ibm.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
References: <6F7DA19D05F3CF40B890C7CA2DB13A42030949CB@ssvlexmb2.amd.com>
	<86802c440601061832m4898e20fw4c9a8360e85cfa17@mail.gmail.com>
	<86802c440601062238r1b304cd4j2d9c8e14a8324618@mail.gmail.com>
	<86802c440601062320r597d6970i3b120ec90f96abce@mail.gmail.com>
	<86802c440601070143v44ee9f4dua2dcef2a536d4c73@mail.gmail.com>
	<m1ek3k2ojo.fsf@ebiederm.dsl.xmission.com>
	<86802c440601071136n14a0851we97f6db04f940d68@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 07 Jan 2006 12:44:17 -0700
In-Reply-To: <86802c440601071136n14a0851we97f6db04f940d68@mail.gmail.com> (yhlu.kernel@gmail.com's
 message of "Sat, 7 Jan 2006 11:36:31 -0800")
Message-ID: <m17j9b3jse.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yhlu <yhlu.kernel@gmail.com> writes:

> MPTABLE in LinuxBIOS is put from 0x20, if the system has too many cpu
> and devices (slots)  the mptable will get bigger than 0x464, so it
> will use 0x40:67....

Then you or someone moved it.  The base in low memory was originally
at 0x500, to avoid just these kinds of problems.

> We need to put mptable to [0xf0000:0x100000] together with acpi
> tables.

Or move it up a few bytes.

> and if it is bigger than 64k, then we have to put it on special
> postion ...from 1K, and pass the posstion of mptable to the kernel via
> command line.
>
> I will update the code in LinuxBIOS.

Thanks.  It is always a good idea not to assign legacy regions of the
address space new meanings.

Eric
