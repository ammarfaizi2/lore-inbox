Return-Path: <linux-kernel-owner+w=401wt.eu-S1751836AbXAVOd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836AbXAVOd1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 09:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbXAVOd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 09:33:27 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:59465 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751836AbXAVOd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 09:33:26 -0500
Date: Mon, 22 Jan 2007 14:44:33 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Wink Saville" <wink@saville.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Asynchronous Messaging
Message-ID: <20070122144433.68598359@localhost.localdomain>
In-Reply-To: <d4cf37a60701220019h7cae91f6nc33bd24761a54c67@mail.gmail.com>
References: <d4cf37a60701220019h7cae91f6nc33bd24761a54c67@mail.gmail.com>
X-Mailer: Claws Mail 2.7.1 (GTK+ 2.10.4; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is accomplished by allocating a page (or more) of memory which
> is executable and mapped into every threads address space. Also, all
> ISR entry points are modified to detect if the code that was interrupted
> was executing within the ACE page. If it was then the ACE code is
> allowed to complete before the ISR continues. This then provides
> the guarantee of atomic execution.

What if you enter the ISR, pass the point of the check and then another
CPU core hits the ACE space ?

Also how do you handle the case where the code gets stuck in your atomic
pages ?

Alan
