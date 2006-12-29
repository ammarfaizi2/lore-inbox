Return-Path: <linux-kernel-owner+w=401wt.eu-S1754954AbWL2Pmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754954AbWL2Pmz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 10:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754985AbWL2Pmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 10:42:55 -0500
Received: from smtp0.telegraaf.nl ([217.196.45.192]:60705 "EHLO
	smtp0.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954AbWL2Pmy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 10:42:54 -0500
Date: Fri, 29 Dec 2006 16:42:51 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061229154251.GR912@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com> <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org> <20061222144134.GH31882@telegraafnet.nl> <20061222154234.GI31882@telegraafnet.nl> <20061228155148.f5469729.akpm@osdl.org> <20061229125108.GK912@telegraafnet.nl> <20061229132759.GL912@telegraafnet.nl> <20061229141058.GM912@telegraafnet.nl> <20061229150132.GN912@telegraafnet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229150132.GN912@telegraafnet.nl>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
On Fri, Dec 29, 2006 at 04:01:32PM +0100, Ard -kwaak- van Breemen wrote:
> On Fri, Dec 29, 2006 at 03:10:58PM +0100, Ard -kwaak- van Breemen wrote:
> > Preliminary patches:
> > - pci fix of Andrews patches
> The printk might be too verbose. I think removing them is ok

I stick with the verbose printk. Because else we will never know
that something is faul.

> since the only thing that has happened is that it prevents
> entering the loop and the semaphores. The only thing that bugs me
> is if list_empty can be used like that. (in other words: don't we
> need semaphores around that).

I was wondering about the validity of pci_devices at that time.
But on the other hand: if that was not wrong, people would have
complained much earlier.

Anyway, I think that's it: those 3 patches will fix and guard the
problems we've seen.

-- 
program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.
