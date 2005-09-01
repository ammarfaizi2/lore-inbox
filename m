Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbVIAVZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbVIAVZv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030395AbVIAVZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:25:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10374 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030394AbVIAVZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:25:50 -0400
Date: Thu, 1 Sep 2005 14:28:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-mm1: PCMCIA problem
Message-Id: <20050901142813.47b349ed.akpm@osdl.org>
In-Reply-To: <200509012314.48434.rjw@sisk.pl>
References: <20050901035542.1c621af6.akpm@osdl.org>
	<200509012314.48434.rjw@sisk.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> On Thursday, 1 of September 2005 12:55, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13/2.6.13-mm1/
> 
> I cannot start PCMCIA on x86-64 SuSE 9.3 on Asus L5D.  Apparently, the following
> command:
> 
> sh -c modprobe --ignore-install firmware_class; echo 30 > /sys/class/firmware/timeout
> 
> loops forever with almost 100% of the time spent in the kernel.
> 
> AFAICS, 2.6.13-rc6-mm2 is also affected, but the mainline kernels are not.

OK.  There are no notable firmware changes in there.  While it's stuck
could you generate a kernel profile?    I do:

readprofile -r
sleep 5
readprofile -n -v -m /boot/System.map | sort -n +2 | tail -40

