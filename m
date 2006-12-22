Return-Path: <linux-kernel-owner+w=401wt.eu-S1423077AbWLVOlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423077AbWLVOlh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 09:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423074AbWLVOlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 09:41:37 -0500
Received: from smtp0.telegraaf.nl ([217.196.45.192]:47419 "EHLO
	smtp0.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423077AbWLVOlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 09:41:36 -0500
Date: Fri, 22 Dec 2006 15:41:34 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: "Zhang, Yanmin" <yanmin.zhang@intel.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061222144134.GH31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2EB70@pdsmsx404.ccr.corp.intel.com> <20061222082248.GY31882@telegraafnet.nl> <20061222003029.4394bd9a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222003029.4394bd9a.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2006 at 12:30:29AM -0800, Andrew Morton wrote:
> To whom do I have to pay how much to get this darn patch tested?
I've altered your patch to do the spin_lock_irqsave in down_read.
I am very ignorant and stupid. That's why I am doing it without
thinking why or why not de irqsave is ok in that region or not.

And the results are:
include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@49
include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@51
include/asm-i386/ide.h ide_default_io_base(): blaat: interrupts were disabled@59

Meaning: it works.

Repeating: I am very stupid, so I don't know if saving the irq state is ok or
not in down_read.
-- 
program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.
