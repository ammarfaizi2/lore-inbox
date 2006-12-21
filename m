Return-Path: <linux-kernel-owner+w=401wt.eu-S1423073AbWLUU0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423073AbWLUU0m (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 15:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423075AbWLUU0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 15:26:42 -0500
Received: from smtp1.telegraaf.nl ([217.196.45.193]:56106 "EHLO
	smtp1.telegraaf.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423073AbWLUU0l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 15:26:41 -0500
X-Greylist: delayed 2038 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Dec 2006 15:26:41 EST
Date: Thu, 21 Dec 2006 20:52:40 +0100
From: Ard -kwaak- van Breemen <ard@telegraafnet.nl>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Chuck Ebbert <76306.1226@compuserve.com>,
       Yinghai Lu <yinghai.lu@amd.com>, take@libero.it, agalanin@mera.ru,
       linux-kernel@vger.kernel.org, bugme-daemon@bugzilla.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Bug 7505] Linux-2.6.18 fails to boot on AMD64 machine
Message-ID: <20061221195240.GS31882@telegraafnet.nl>
References: <117E3EB5059E4E48ADFF2822933287A401F2E7C5@pdsmsx404.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117E3EB5059E4E48ADFF2822933287A401F2E7C5@pdsmsx404.ccr.corp.intel.com>
User-Agent: Mutt/1.5.9i
X-telegraaf-MailScanner-From: ard@telegraafnet.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Dec 21, 2006 at 04:04:04PM +0800, Zhang, Yanmin wrote:
> I couldn't reproduce it on my EM64T machine. I instrumented function start_kernel and
> didn't find irq was enabled before calling init_IRQ. It'll be better if the reporter could
> instrument function start_kernel to capture which function enables irq.
Just diving into the sources.
Is that something like:
if(!raw_irqs_disabled_flags) printk "irqs are enabled";

(At that moment it might have crashed already.. :-)).

I don't see the complete context yet, but I hope the irq is
triggered after the irq is somehow enabled.

BTW: the panic occurs on half of my boards on tyan S2891 with 2
opterons, of which the only difference seems to be the purchase
date (and hence probably the motherboard revisions). (Haven't got
time yet to pull them out of the rack and compare the
motherboards).


-- 
program signature;
begin  { telegraaf.com
} writeln("<ard@telegraafnet.nl> TEM2");
end
.
