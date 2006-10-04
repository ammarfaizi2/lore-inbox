Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWJDWyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWJDWyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 18:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWJDWyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 18:54:25 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:12979 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751208AbWJDWyZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 18:54:25 -0400
Date: Wed, 4 Oct 2006 18:53:49 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Steven Truong <midair77@gmail.com>
Cc: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>,
       linux-kernel@vger.kernel.org,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: kexec / kdump kernel panic
Message-ID: <20061004225349.GA4585@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <28bb77d30610031718r51dfb003ge22c082d3b4cacb@mail.gmail.com> <200610040346.k943kvwM006684@turing-police.cc.vt.edu> <28bb77d30610041438r3c3dfd8ejc7344761704747fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28bb77d30610041438r3c3dfd8ejc7344761704747fd@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2006 at 02:38:53PM -0700, Steven Truong wrote:
> Hi, Valdis.  No, I actually used 2 different kernels for this:  one
> for system kernel and the other for captured/crash kernel.
> 
> System kernel .config file with these options
> 
> CONFIG_KEXEC=y
> CONFIG_CRASH_DUMP=y
> CONFIG_PHYSICAL_START=0x1000000
> CONFIG_SYSFS=y
> CONFIG_DEBUG_INFO=y
> 

Valdis, you don't have to enable CONFIG_CRASH_DUMP in your system kernel.
The moment you enable it, by default it thinks that I am the capture kernel
and sets the value of CONFIG_PHYSICAL_START to 16MB (0x1000000) instead
of 1MB (0x100000).

Your procedure seems to be right. Please also paste output of /proc/iomem
in first kernel.

You can find more info on following link.

http://lse.sourceforge.net/kdump/

I am also copying the mail to fastboot mailing list where generally
kexec/kdump discussions take place

Thanks
Vivek
