Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbTILTBW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 15:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbTILTBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 15:01:22 -0400
Received: from mid-2.inet.it ([213.92.5.19]:55286 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S261878AbTILTBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 15:01:21 -0400
Message-ID: <002201c37960$d9cfc740$f0ae7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: "Timothy Miller" <miller@techsource.com>
Cc: "Arjan van de Ven" <arjanv@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030909175821.GL16080@Synopsys.COM> <001d01c37703$8edc10e0$36af7450@wssupremo> <20030910064508.GA25795@Synopsys.COM> <015601c3777c$8c63b2e0$5aaf7450@wssupremo> <1063185795.5021.4.camel@laptop.fenrus.com> <01c601c3777f$97c92680$5aaf7450@wssupremo> <20030910114414.B14352@devserv.devel.redhat.com> <01f801c37783$9ead8960$5aaf7450@wssupremo> <20030910121453.B9878@devserv.devel.redhat.com> <024601c37785$e3e07680$5aaf7450@wssupremo> <3F621355.3050009@techsource.com>
Subject: Re: Efficient IPC mechanism on Linux
Date: Fri, 12 Sep 2003 21:05:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pardon my ignorance here, but the impression I get is that changing a
> page table entry is not as simple as just writing to a bit somewhere.  I
> suppose it is if the page descriptor is not loaded into the TLB, but if
> it is, then you have to ensure that the TLB entry matches the page
> table; this may not be a quick operation.
>
> I can think of a lot of other possible complications to this.

I stopped writing about this question a lot of time ago.
However, here we are.

If you modify the page tables as in my example (and then if you do so only
for B's pagetable)
you can be sure the things you're modifying were not present in Firmware
TLBs, not yet.

Because those pagetable entries refer to a logical address interval
you've just allocated in B address space.

Bye,
Luca

