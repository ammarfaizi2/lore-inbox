Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbUCPFDq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 00:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUCPFDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 00:03:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:55248 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262649AbUCPFDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 00:03:45 -0500
Date: Mon, 15 Mar 2004 21:03:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: kenneth.w.chen@intel.com, linux-kernel@vger.kernel.org
Subject: Re: Patch - make config_max_raw_devices work
Message-Id: <20040315210341.707c85dc.akpm@osdl.org>
In-Reply-To: <20040316023946.GO19737@krispykreme>
References: <200403160053.i2G0rNm31241@unix-os.sc.intel.com>
	<20040315181406.2f2d8f38.akpm@osdl.org>
	<20040316023946.GO19737@krispykreme>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
>  
> > Badari wrote basically the same patch a couple of months back.  I dropped
> > it then, too ;)
> > 
> > raw is a deprecated interface and if we keep on adding new features to it,
> > we will never be rid of the thing.  If your application requires more than
> > 256 raw devices, please convert it to open the block device directly,
> > passing in the O_DIRECT flag.
> 
> We only deprecated this thing on the 4th Feb 2004. I want to see the raw
> driver die but we cant expect apps to change their interfaces in the space
> of a month.

Nobody has complained about the 256-device limit thus far.  I fully
expected to lose this one, but I don't think I've bitched about it enough
yet.

> Can we reach a compromise? :)

OK, how about a udelay(10) in each I/O?
