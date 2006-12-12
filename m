Return-Path: <linux-kernel-owner+w=401wt.eu-S932271AbWLLR3b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWLLR3b (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWLLR3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:29:31 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:33687 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932271AbWLLR3a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:29:30 -0500
Date: Tue, 12 Dec 2006 17:37:39 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata and sata?
Message-ID: <20061212173739.1304194f@localhost.localdomain>
In-Reply-To: <457ED87A.5@comcast.net>
References: <457ED87A.5@comcast.net>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I no longer have two kernels to test through; I can't tell if the speed
> is back or not.  Nothing in dmesg tells me if SATA is using DMA or
> 32-bit IO support though, so I don't know... lack of knowledge over here
> is killing me for troubleshooting this on my own.

The dmesg message shows the mode selected. It should be the highest speed
but in one or two cases it selects UDMA33 only. I've fixed one of those
caused by us relying on a bit not defined in older controllers. We've
still got a case in the newer chips where BIOS setup doesn't set the
flags properly. Old IDE has a hackish workaround for that and I'll
probably end up porting it over.

