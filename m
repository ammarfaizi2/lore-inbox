Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264673AbUEaPeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264673AbUEaPeK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 11:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264677AbUEaPeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 11:34:10 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:30469 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264673AbUEaPeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 11:34:08 -0400
Subject: Re: swsusp fails short on memory
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040527193641.GE509@openzaurus.ucw.cz>
References: <1085582116.1785.6.camel@teapot.felipe-alfaro.com>
	 <20040527193641.GE509@openzaurus.ucw.cz>
Content-Type: text/plain
Message-Id: <1086017644.1694.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Mon, 31 May 2004 17:34:05 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-05-27 at 21:36, Pavel Machek wrote:
> Hi!
> 
> > I'm somewhat ignorant on the inner workings of swsusp. I have a 256MB
> > laptop machine running 2.6.7-rc1-bk2 + ACPI + swsusp two swap
> > partitions, a 256MB swap partition on /dev/hda4 plus another 256MB swap
> > on /dev/hda5. When trying to hibernate to disk, swsusp fails with the
> > following error message:
> 
> You need just one swap partition (256MB
> should be enough).
>  Try suspending from single user mode.

/proc/sys/vm/swappiness = 0 was the culprit of all my problems :)
Thanks!

