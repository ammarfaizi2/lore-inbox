Return-Path: <linux-kernel-owner+w=401wt.eu-S1161047AbXAEKku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161047AbXAEKku (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 05:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161049AbXAEKku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 05:40:50 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33544 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161047AbXAEKkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 05:40:49 -0500
Date: Fri, 5 Jan 2007 10:51:13 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: "Ahmed S. Darwish" <darwish.07@gmail.com>,
       Rolf Eike Beer <eike-kernel@sf-tec.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
Message-ID: <20070105105113.120d72c9@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0701050513360.23145@localhost.localdomain>
References: <20070105063600.GA13571@Ahmed>
	<200701050910.11828.eike-kernel@sf-tec.de>
	<20070105100610.GA382@Ahmed>
	<Pine.LNX.4.64.0701050513360.23145@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> represents a kmalloc->kzalloc cleanup (there's lots of those), and
> also see if you can replace one of these:
> 
>   sizeof(struct blah)
> 
> with one of these:
> 
>   sizeof(*blahptr)

Patches that do this will get rejected by the tty maintainer in favour of
the clarity of the sizeof(struct xyz) format 8)

Ahmed - if you can send me a patch for the tty_io/tty_ioctl code which
switches to kzalloc where it makes sense and removes un-needed casts I'll
review it and push the bits that look sane upstream. 

Alan
