Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272143AbTG2W5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 18:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272155AbTG2W5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 18:57:14 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:4596 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272143AbTG2W5N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 18:57:13 -0400
Subject: Re: [uClinux-dev] Kernel 2.6 size increase
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Bernardo Innocenti <bernie@develer.com>, Willy Tarreau <willy@w.ods.org>,
       Christoph Hellwig <hch@lst.de>,
       uClinux development list <uclinux-dev@uclinux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030729222921.GK16051@ip68-0-152-218.tc.ph.cox.net>
References: <200307232046.46990.bernie@develer.com>
	 <200307240007.15377.bernie@develer.com>
	 <20030723222747.GF643@alpha.home.local>
	 <200307242227.16439.bernie@develer.com>
	 <20030729222921.GK16051@ip68-0-152-218.tc.ph.cox.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059518889.6838.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jul 2003 23:48:10 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-29 at 23:29, Tom Rini wrote:
> 
> Well, from Pat's talk at OLS, it seems like sysfs would be an important
> part of 'sleep', which is something at least some embedded systems care
> about.

sysfs is relevant for bigger systems but for small embedded stuff the whole
PM layer is fairly "so what". At that level your hardware is tightly defined
and you *know* the power management ordering. Policy becomes critical for 
performance and gets done at a very fine grained level - things like waking
up the flash for a read then turning it back off on a timer for example.

