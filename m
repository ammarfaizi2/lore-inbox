Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751246AbWCISbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWCISbk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 13:31:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWCISbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 13:31:40 -0500
Received: from [81.2.110.250] ([81.2.110.250]:32233 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751246AbWCISbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 13:31:40 -0500
Subject: Re: Kernel panic on PC with broken hard drive, after DMA errors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Martin Michlmayr <tbm@cyrius.com>
Cc: Robert Hancock <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060309165357.GB10572@deprecation.cyrius.com>
References: <5Okau-77g-9@gated-at.bofh.it> <440FA916.5070703@shaw.ca>
	 <20060309151459.GD2891@deprecation.cyrius.com>
	 <1141922743.16745.12.camel@localhost.localdomain>
	 <20060309165357.GB10572@deprecation.cyrius.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 09 Mar 2006 18:37:05 +0000
Message-Id: <1141929425.16745.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-03-09 at 16:53 +0000, Martin Michlmayr wrote:
> * Alan Cox <alan@lxorguk.ukuu.org.uk> [2006-03-09 16:45]:
> > Ancient known problem. I'd be interested if you can however break
> > libata and the PATA IDE patches the same way.
> 
> I can try, but like I said, the hard drive acts pretty arbitrarily and
> won't always fail when I want it to.  Do you know if there's a way to
> trigger the problem?  Otherwise I'll just try a couple of times,
> but without a good way to trigger the problem I cannot really say if
> it's gone with libata.

You could try heavy I/O (find / -print type stuff), or if its specific
problem blocks then cp /dev/hda (/dev/sda for libata) /dev/null.

Libata should either error correctly or recover cleanly from the
problems.

