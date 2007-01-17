Return-Path: <linux-kernel-owner+w=401wt.eu-S932749AbXAQUdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932749AbXAQUdm (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 15:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbXAQUdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 15:33:42 -0500
Received: from terminus.zytor.com ([192.83.249.54]:47754 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932749AbXAQUdl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 15:33:41 -0500
Message-ID: <45AE8818.1050803@zytor.com>
Date: Wed, 17 Jan 2007 12:33:28 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
MIME-Version: 1.0
To: Tomasz Chmielewski <mangoo@wpkg.org>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
References: <45AE1D65.4010804@wpkg.org> <Pine.LNX.4.61.0701171435060.18562@yvahk01.tjqt.qr> <45AE2E25.50309@wpkg.org>
In-Reply-To: <45AE2E25.50309@wpkg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Chmielewski wrote:
> 
> All right.
> I see that initramfs is attached to the kernel itself.
> 
> So it leaves me only a question: will I fit all tools into 300 kB 
> (considering I'll use uClibc and busybox)?
> 

You don't need to use busybox and have a bunch of tools.

The klibc distribution comes with "kinit", which does the equivalent to 
the kernel root-mounting code; it's in the tens of kilobytes, at least 
on x86.  If you're using ARM, you can compile it as Thumb.

	-hpa

