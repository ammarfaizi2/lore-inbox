Return-Path: <linux-kernel-owner+w=401wt.eu-S1762718AbWLKKMl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762718AbWLKKMl (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762716AbWLKKMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:12:41 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57623 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1762712AbWLKKMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:12:40 -0500
Date: Mon, 11 Dec 2006 10:20:16 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Corey Minyard <cminyard@mvista.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Tilman Schmidt <tilman@imap.cc>, linux-serial@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
Message-ID: <20061211102016.43e76da2@localhost.localdomain>
In-Reply-To: <457CB32A.2060804@mvista.com>
References: <4533B8FB.5080108@mvista.com>
	<20061210201438.tilman@imap.cc>
	<Pine.LNX.4.60.0612102117590.9993@poirot.grange>
	<457CB32A.2060804@mvista.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006 19:23:54 -0600
Corey Minyard <cminyard@mvista.com> wrote:

> Nothing has come of this yet.  But we have these two requests and a 
> request from Russell Doty at Redhat.
> 
> It would be nice to know if this type of thing was acceptable or not, 
> and the problems with the patch.  The patch is at 
> http://home.comcast.net/~minyard

This looks wrong. You already have a kernel interface to serial drivers.
It is called a line discipline. We use it for ppp, we use it for slip, we
use it for a few other things such as attaching sync drivers to some
devices.

Discussions of the form  "my line discipline has no way to do 'xyz'" are
the ones that need to happen IMHO.

Alan
