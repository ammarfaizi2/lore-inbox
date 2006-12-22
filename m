Return-Path: <linux-kernel-owner+w=401wt.eu-S1946019AbWLVKQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946019AbWLVKQP (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946020AbWLVKQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:16:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34520 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946019AbWLVKQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:16:14 -0500
Date: Fri, 22 Dec 2006 01:43:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Stefano Takekawa <take@libero.it>
Cc: Ard -kwaak- van Breemen <ard@telegraafnet.nl>,
       "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-Id: <20061222014341.5ba33788.akpm@osdl.org>
In-Reply-To: <1166779971.16097.8.camel@proton.twominds.it>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com>
	<20061222082248.GY31882@telegraafnet.nl>
	<20061222003029.4394bd9a.akpm@osdl.org>
	<1166779971.16097.8.camel@proton.twominds.it>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006 10:32:51 +0100
Stefano Takekawa <take@libero.it> wrote:

> Applied to 2.6.19 it doesn't change anything. It still panics.

Really?

And you can confirm that converting pci_bus_sem back into a spinlock fixes
it?

> How can I have something similar to a serial console on a laptop without
> serial port but with a parallel one? Will netconsole work?
> 

No, netconsole isn't available for quite some time after the kernel starts.

Your best bet would be to boot with `earlyprintk=vga vga=N', where N is
something which gives lots of rows.  0F01, perhaps.

Then, take a digital photo of the display.
