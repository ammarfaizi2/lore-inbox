Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262708AbVBYOnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262708AbVBYOnY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 09:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbVBYOnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 09:43:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40355 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262708AbVBYOme (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 09:42:34 -0500
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16927.14697.76256.482062@segfault.boston.redhat.com>
Date: Fri, 25 Feb 2005 09:42:49 -0500
To: Christian Borntraeger <linux-kernel@borntraeger.net>
Cc: linux-kernel@vger.kernel.org, "shabanip" <shabanip@avapajoohesh.com>
Subject: Re: how to capture kernel panics
In-Reply-To: <200502251517.56254.linux-kernel@borntraeger.net>
References: <52765.69.93.110.242.1109288148.squirrel@69.93.110.242>
	<200502251517.56254.linux-kernel@borntraeger.net>
X-Mailer: VM 7.19 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: how to capture kernel panics; Christian Borntraeger <linux-kernel@borntraeger.net> adds:

linux-kernel> shabanip wrote:
>> is there any way to capture and log kernel panics on disk or ...?

linux-kernel> In former times, the Linux kernel tried to sync in the panic
linux-kernel> function. (If the panic did not happen in interrupt context)
linux-kernel> Unfortunately this had severe side effects in cases where the
linux-kernel> panic was triggered by file system block device code or any
linux-kernel> other part which is necessary for syncing. In most cases the
linux-kernel> call trace never made it onto disk anyway. So currently the
linux-kernel> kernel does not support saving a panic.

linux-kernel> Apart from using a serial console, you might have a look at
linux-kernel> several kexec/kdump/lkcd tools where people are working on
linux-kernel> being able to dump the memory of a paniced kernel.

Or netconsole, which will dump printk's do the server:port of your
choosing.

-Jeff
