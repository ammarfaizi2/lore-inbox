Return-Path: <linux-kernel-owner+w=401wt.eu-S932715AbWLNNIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932715AbWLNNIU (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 08:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932717AbWLNNIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 08:08:20 -0500
Received: from www.osadl.org ([213.239.205.134]:44726 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932715AbWLNNIT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 08:08:19 -0500
From: =?utf-8?q?Hans-J=C3=BCrgen_Koch?= <hjk@linutronix.de>
Organization: Linutronix
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [GIT PATCH] more Driver core patches for 2.6.19
Date: Thu, 14 Dec 2006 14:08:16 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061213195226.GA6736@kroah.com> <200612141056.03538.hjk@linutronix.de> <20061214123945.734b5261@localhost.localdomain>
In-Reply-To: <20061214123945.734b5261@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612141408.17329.hjk@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Dezember 2006 13:39 schrieb Alan:
> On Thu, 14 Dec 2006 10:56:03 +0100
> Hans-Jürgen Koch <hjk@linutronix.de> wrote:
> 
> > * They let somebody write the small kernel module they need to handle 
> > interrupts in a _clean_ way. This module can easily be checked and could
> > even be included in a mainline kernel.
> 
> And might as well do the mmap work as well. I'm not clear what uio gives
> us that a decently written pair of PCI and platform template drivers for
> people to use would not do more cleanly.

* Creation of /dev device files.
* Creation of standardized sysfs files.
* Interrupt registration and handling.
* mmap for physical and logical memory.
* read, poll, and fasync for interrupt handling.
* a predefined, clean design that the hardware manufacturer can use.

> 
> Also many of these cases you might not want stuff in userspace but the
> uio model would push it that way which seems to be an unfortunate side
> effect. Yes some probably do want to go that way but not all.

Alright, but everybody has the choice. If the alternative is to have no
Linux drivers at all because it's too expensive, then somebody might
consider UIO. To have the big parts of the driver in userspace allows
them to remain stable across different kernel versions. Driver updates
can take place without changing the kernel. For some manufacturers 
these will be strong arguments in favor of UIO.

Hans
 
