Return-Path: <linux-kernel-owner+w=401wt.eu-S1754835AbWLVNVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754835AbWLVNVL (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 08:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754834AbWLVNVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 08:21:11 -0500
Received: from smtpa2.aruba.it ([62.149.128.211]:45664 "HELO smtpa2.aruba.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754835AbWLVNVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 08:21:10 -0500
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
From: Stefano Takekawa <take@libero.it>
To: Andrew Morton <akpm@osdl.org>
Cc: Ard -kwaak- van Breemen <ard@telegraafnet.nl>,
       "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20061222014341.5ba33788.akpm@osdl.org>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com>
	 <20061222082248.GY31882@telegraafnet.nl>
	 <20061222003029.4394bd9a.akpm@osdl.org>
	 <1166779971.16097.8.camel@proton.twominds.it>
	 <20061222014341.5ba33788.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 22 Dec 2006 14:23:07 +0100
Message-Id: <1166793787.11859.7.camel@proton.twominds.it>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 
Content-Transfer-Encoding: 7bit
X-Spam-Rating: smtpa2.aruba.it 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il giorno ven, 22/12/2006 alle 01.43 -0800, Andrew Morton ha scritto:
> On Fri, 22 Dec 2006 10:32:51 +0100
> Stefano Takekawa <take@libero.it> wrote:
> 
> > Applied to 2.6.19 it doesn't change anything. It still panics.
> 
> Really?
> 
> And you can confirm that converting pci_bus_sem back into a spinlock fixes
> it?
> 
> > How can I have something similar to a serial console on a laptop without
> > serial port but with a parallel one? Will netconsole work?
> > 
> 
> No, netconsole isn't available for quite some time after the kernel starts.
> 
> Your best bet would be to boot with `earlyprintk=vga vga=N', where N is
> something which gives lots of rows.  0F01, perhaps.
> 
> Then, take a digital photo of the display.

I can't take any digital photo. Well I got this:
2.6.19 + lib/rwsem-spinlock.c patched + hdc=ide-cd or idebus=66 >> panic
2.6.19 + lib/rwsem-spinlock.c patched + no ide_setup calls >> works!!!
2.6.19 + spinlock reversed >> always works

-- 
Stefano Takekawa
take@libero.it

Frank:  And why do days get longer in the summer?
Ernest: Because heat makes things expand!


