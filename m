Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbUBPFNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 00:13:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUBPFNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 00:13:10 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:63962 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S263325AbUBPFNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 00:13:07 -0500
From: Michael Frank <mhf@linuxmail.org>
To: lepton <lepton@mail.goldenhope.com.cn>, linux-kernel@vger.kernel.org
Subject: Re: [BUG]linux-2.4.24 with k8 numa support panic when init scsi
Date: Mon, 16 Feb 2004 13:22:21 +0800
User-Agent: KMail/1.5.4
References: <20040208143740.GA25010@lepton.goldenhope.com.cn.suse.lists.linux.kernel> <20040210143208.7b1d9940.ak@suse.de> <20040216034909.GA11557@lepton.goldenhope.com.cn>
In-Reply-To: <20040216034909.GA11557@lepton.goldenhope.com.cn>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402161303.30492.mhf@linuxmail.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Monday 16 February 2004 11:49, lepton wrote:
> I have do some test on weekend. The result is:
> 
> 1. Compiling kernel with gcc 3.2:
>    2.4.20 2.4.21: can boot, can mount reiserfs filesystem
>    2.4.22: can boot, can mount reiserfs filesystem, but will panic
>    when reboot. It is perhaps because of "reboot=triple" ? 
>    2.4.23: panic when init scsi, like before.
>    2.4.24: can boot, can mount reiserfs filesystem, but will panic when
>    reboot.
> 
> 2. Compiling kernel with gcc 3.3
>    2.4.20: can not compile.... 
>    2.4.21: can boot, can mount reiserfs filesystem
>    2.4.22: can boot, can mount reiserfs filesystem, but will panic when
>    reboot.
>    2.4.23: panic when init scsi, like before
>    2.4.24: panic when init scsi, like before
> 
> 3. when panic, reboot=bios or reboot=triple both can not work.
> 
>    2.4.24 changes a little from 2.4.23, so it is strange system will
>    panic in 2.4.23 and don't panic in 2.4.24 when using gcc 3.2
>    Perhaps there is some random error?

Be sure that you have in your .config:

CONFIG_M686=y
# CONFIG_FRAME_POINTER is not set

and compile with gcc295.

Regards
Michael

