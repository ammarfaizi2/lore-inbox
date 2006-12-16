Return-Path: <linux-kernel-owner+w=401wt.eu-S1750861AbWLPDFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWLPDFU (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 22:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753466AbWLPDFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 22:05:20 -0500
Received: from mx1.redhat.com ([66.187.233.31]:41397 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbWLPDFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 22:05:19 -0500
Date: Fri, 15 Dec 2006 22:05:11 -0500
From: Dave Jones <davej@redhat.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18.5 usb/sysfs bug.
Message-ID: <20061216030511.GA25378@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pete Zaitcev <zaitcev@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061215175027.GA17987@redhat.com> <20061215175344.GA15871@kroah.com> <20061215213715.GB15792@redhat.com> <20061215174750.e1389c0d.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215174750.e1389c0d.zaitcev@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2006 at 05:47:50PM -0800, Pete Zaitcev wrote:
 > On Fri, 15 Dec 2006 16:37:15 -0500, Dave Jones <davej@redhat.com> wrote:
 > 
 > > Linux version 2.6.18-1.2864.fc6 (brewbuilder@hs20-bc2-4.build.redhat.com) (gcc version 4.1.1 20061011 (Red Hat 4.1.1-30)) #1 SMP Fri Dec 15 13:14:58 EST 2006
 > > Kernel command line: ro root=/dev/VolGroup00/LogVol00 profile=1 vga=791
 > 
 > > audit(1166218060.464:4): avc:  denied  { search } for  pid=2678 comm="pcscd" name="usbdev2.4_ep03" dev=sysfs ino=1384 scontext=system_u:system_r:pcscd_t:s0 tcontext=system_u:object_r:sysfs_t:s0 tclass=dir
 > > BUG: unable to handle kernel NULL pointer dereference at virtual address 0000000b
 > 
 > But if you boot with selinux=0, everything works, right? Printk time.

Good spotting, yes it does.  And come to think of it, this only
recently started happening after some updates got applied, so it's
likely that policy got stricter somehow.  Still shouldn't cause
an oops though obviously.

		Dave

-- 
http://www.codemonkey.org.uk
