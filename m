Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbUKIPfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbUKIPfQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 10:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261556AbUKIPfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 10:35:16 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:54443 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261423AbUKIPfL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 10:35:11 -0500
Date: Tue, 9 Nov 2004 09:34:00 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Leo Przybylski <leo@leosandbox.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Blast and data miscompare
Message-ID: <20041109093400.34b49953@localhost>
In-Reply-To: <41847C52.8030702@leosandbox.org>
References: <41847C52.8030702@leosandbox.org>
Organization: LTC
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have tried searching on this issue, but found nothing. I heard from a 
> kernel developer at work that a memory error was discovered recently in 
> the linux 2.6 kernel that causes data miscompare errors in the generic 
> scsi driver when executing blast tests.
> 
> Does anyone know more about this???

Not sure if it's the same problem.  But we were seeing a miscompare on
2.4 due to a incorrect COW happening, followed by a hardware hash hole
w/ PPC64.

To fix it we had to make sure that the PTE was cleared and the TLB's
flushed before the new PTE was established.

Martin, was this fixed on 2.6?

Thanks,
Jake
