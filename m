Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752052AbWG1RNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbWG1RNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbWG1RNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:13:08 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:2705 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1752052AbWG1RNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:13:06 -0400
Date: Fri, 28 Jul 2006 19:11:31 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: ProfiHost - Stefan Priebe <s.priebe@profihost.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nathan Scott <nathans@sgi.com>, Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: XFS / Quota Bug in  2.6.17.x and 2.6.18x
In-Reply-To: <44C8A5F1.7060604@profihost.com>
Message-ID: <Pine.LNX.4.61.0607281909080.4972@yvahk01.tjqt.qr>
References: <44C8A5F1.7060604@profihost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The crash only occurs if you use quota and IDE without barrier support.

I don't quite get this. I do use quota, and have barriers turned 
off (either explicitly or because the drive does not support it),
but yet no error message like you posted. Do I just have luck?

> The Problem is, that on a new mount of a root filesystem - the flag VFS_RDONLY
> is set - and so no barrier check is done before checking quota. With this patch
> barrier check is done always. The partition should not be mounted at that
> moment. For mount -o remount, rw or something like this it uses another
> function where VFS_RDONLY is checked.

Jan Engelhardt
-- 
