Return-Path: <linux-kernel-owner+w=401wt.eu-S1762989AbWLKRc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762989AbWLKRc0 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762990AbWLKRc0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:32:26 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41181 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762988AbWLKRcZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:32:25 -0500
Date: Mon, 11 Dec 2006 17:40:04 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Tilman Schmidt <tilman@imap.cc>
Cc: Corey Minyard <cminyard@mvista.com>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       linux-serial@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
Message-ID: <20061211174004.5605fb47@localhost.localdomain>
In-Reply-To: <457D8E35.9050706@imap.cc>
References: <4533B8FB.5080108@mvista.com>
	<20061210201438.tilman@imap.cc>
	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>
	<457CB32A.2060804@mvista.com>
	<20061211102016.43e76da2@localhost.localdomain>
	<457D8E35.9050706@imap.cc>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2006 17:58:29 +0100
Tilman Schmidt <tilman@imap.cc> wrote:

> On Mon, 11 Dec 2006 10:20:16 +0000, Alan wrote:
> > This looks wrong. You already have a kernel interface to serial drivers.
> > It is called a line discipline. We use it for ppp, we use it for slip, we
> > use it for a few other things such as attaching sync drivers to some
> > devices.
> 
> I was under the impression that line disciplines need a user space
> process to open the serial device and push them onto it. 

Yes that is correct. You need a way for the user to tell you which port
to use and to the permission and usage management for it anyway (as well
as load the module and configure settings), so this seems quite
reasonable.
