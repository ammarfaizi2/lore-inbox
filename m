Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265619AbUATTn4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 14:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265639AbUATTn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 14:43:56 -0500
Received: from mail3.absamail.co.za ([196.35.40.69]:7211 "EHLO absamail.co.za")
	by vger.kernel.org with ESMTP id S265619AbUATTnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 14:43:53 -0500
Subject: RE: [2.6.1 MCE falseness?] Hardware reports non-fatal error
From: Niel Lambrechts <antispam@absamail.co.za>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1074627735.4414.10.camel@ksyrium.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 20 Jan 2004 21:43:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried the mentioned patch, with a modification for my CPU type, but
still get the problem:

"Jan 20 21:30:23 ksyrium kernel: MCE: The hardware reports a non fatal,
correctable incident occurred on CPU 0.
Jan 20 21:30:23 ksyrium kernel: MCE: startbank = 1, vendor : 0, x86 = 6,
model = 9, mask = 5.
Jan 20 21:30:23 ksyrium kernel: Bank 1: f200000000000185"

As you can see, I added a little extra debugging info. Here is the
relevant portion of the code:
" if ((boot_cpu_data.x86_vendor == X86_VENDOR_AMD && boot_cpu_data.x86
== 6) || (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL &&
boot_cpu_data.x86 == 6 && boot_cpu_data.x86_model == 9 &&
boot_cpu_data.x86_mask == 5))

startbank = 1;"

Comments would be appreciated.

-Niel



