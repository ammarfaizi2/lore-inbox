Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265365AbUBPGlu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 01:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265369AbUBPGlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 01:41:50 -0500
Received: from [220.249.10.10] ([220.249.10.10]:44165 "EHLO
	mail.goldenhope.com.cn") by vger.kernel.org with ESMTP
	id S265365AbUBPGlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 01:41:49 -0500
Date: Mon, 16 Feb 2004 14:41:40 +0800
From: =?gb2312?B?zuLMzg==?= <wutao@mail.goldenhope.com.cn>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG]linux-2.4.24 with k8 numa support panic when init scsi
Message-ID: <20040216064140.GA12497@lepton.goldenhope.com.cn>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040208143740.GA25010@lepton.goldenhope.com.cn.suse.lists.linux.kernel> <20040210143208.7b1d9940.ak@suse.de> <20040216034909.GA11557@lepton.goldenhope.com.cn> <200402161303.30492.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402161303.30492.mhf@linuxmail.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using a dual Operron AMD64 box...
I am building a 64 bit kernel. So I think I can't use gcc295
or CONFIG_M686

On Mon, Feb 16, 2004 at 01:22:21PM +0800, Michael Frank wrote:
> 
> On Monday 16 February 2004 11:49, lepton wrote:
> > I have do some test on weekend. The result is:
> > 
> > 1. Compiling kernel with gcc 3.2:
> >    2.4.20 2.4.21: can boot, can mount reiserfs filesystem
> >    2.4.22: can boot, can mount reiserfs filesystem, but will panic
> >    when reboot. It is perhaps because of "reboot=triple" ? 
> >    2.4.23: panic when init scsi, like before.
> >    2.4.24: can boot, can mount reiserfs filesystem, but will panic when
> >    reboot.
> > 
> > 2. Compiling kernel with gcc 3.3
> >    2.4.20: can not compile.... 
> >    2.4.21: can boot, can mount reiserfs filesystem
> >    2.4.22: can boot, can mount reiserfs filesystem, but will panic when
> >    reboot.
> >    2.4.23: panic when init scsi, like before
> >    2.4.24: panic when init scsi, like before
> > 
> > 3. when panic, reboot=bios or reboot=triple both can not work.
> > 
> >    2.4.24 changes a little from 2.4.23, so it is strange system will
> >    panic in 2.4.23 and don't panic in 2.4.24 when using gcc 3.2
> >    Perhaps there is some random error?
> 
> Be sure that you have in your .config:
> 
> CONFIG_M686=y
> # CONFIG_FRAME_POINTER is not set
> 
> and compile with gcc295.
> 
> Regards
> Michael
