Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263185AbUFCKja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbUFCKja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 06:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbUFCKja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 06:39:30 -0400
Received: from hera.cwi.nl ([192.16.191.8]:13207 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263162AbUFCKjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 06:39:13 -0400
Date: Thu, 3 Jun 2004 12:39:07 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Frediano Ziglio <freddyz77@tin.it>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
Message-ID: <20040603103907.GV23408@apps.cwi.nl>
References: <40BA2213.1090209@pobox.com> <20040530183609.GB5927@pclin040.win.tue.nl> <40BA2E5E.6090603@pobox.com> <20040530200300.GA4681@apps.cwi.nl> <s5g8yf9ljb3.fsf@patl=users.sf.net> <20040531180821.GC5257@louise.pinerecords.com> <1086245495.3988.4.camel@freddy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086245495.3988.4.camel@freddy>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 08:51:35AM +0200, Frediano Ziglio wrote:

> Actually I'm writing two patch:
>  - extending EDD code to provide DPTE informations and signature for all
> drives
>  - modify IDE code to match BIOS disks.

That second part is undesirable.
The Linux IDE code is not interested in getting a conjecture about
how other operating systems would name or number the disks.

> How to match BIOS with Linux?

It is impossible. But you can easily do a 95% job.

> I think it's important to know BIOS point of view. Linux provide these
> information so we have two choices to solve the problem:
> - correct the informations we return
> - do not return anything and let user space programs do the job!

Yes, leave it to user space. That is what we do today.

> - EDD 2.0. I don't understand why Linux code int 41h/46h and ignore
> these informations.

Long ago, long before EDD, disks actually had a geometry, and it was
necessary to find it in order to do I/O to e.g. MFM disks.
Today disk geometry is not related to the disk, but to the BIOS.
The kernel has no need to know it.

Andries
