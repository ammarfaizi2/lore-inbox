Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbWEOUxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbWEOUxM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 16:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWEOUxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 16:53:12 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:5561 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S932072AbWEOUxK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 16:53:10 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [FIXED] Re: Total machine lockup w/ current kernels while installing from CD
Date: Mon, 15 May 2006 22:53:02 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <200605110322.14774.bero@arklinux.org> <200605152232.04304.bero@arklinux.org> <20060515134537.78e117dc.akpm@osdl.org>
In-Reply-To: <20060515134537.78e117dc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605152253.02638.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 15. May 2006 22:45, Andrew Morton wrote:
> It's odd that we'll run initrds in a !SYSTEM_RUNNING state.

True, especially because we run initramfs in SYSTEM_RUNNING state.

> It's not an oops - it's sort-of a warning.  Did the system actually
> continue to run and boot up OK?

No, it was a lockup and the system just hung at the point forever, so the 
lockup detection was right.

> If so, I'd assume that the ext3 filesystem was mounted on a very slow
> device - perhaps an IDE disk in PIO mode?

That too - happened with a pretty stupid 5-liner installation script that just 
formats the disk and installs a set of customized rpms from CD.

The hw we installed this on is Asus Pundit-R boxes, which means, basically, 
weird IDE setup (no secondary IDE --> harddisk on hda, CD drive on hdb) on an 
ATI IGP chipset, not exactly the fastest out there.
