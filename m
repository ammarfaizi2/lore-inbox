Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270766AbTHHKte (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 06:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271144AbTHHKte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 06:49:34 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:16138 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S270766AbTHHKtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 06:49:33 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: hjl@lucon.org (H. J. Lu), linux-kernel@vger.kernel.org
Subject: Re: Initrd problem with 2.6 kernel
In-Reply-To: <20030807223019.GA27359@lucon.org>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.21-2-686-smp (i686))
Message-Id: <E19l4o8-0001Jv-00@gondolin.me.apana.org.au>
Date: Fri, 08 Aug 2003 20:49:16 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. J. Lu <hjl@lucon.org> wrote:
> There is a chicken and egg problem with initrd on 2.6. When
> root=/dev/xxx is passed to kernel, kernel will call try_name, which
> uses /sys/block/drive/dev, to find out the device number for ROOT_DEV.
> The problem is /sys/block/drive may not exist if the driver is loaded
> by /linuxrc in initrd. As the result, /linuxrc can't use
> /proc/sys/kernel/real-root-dev to determine the root device number.

You can replicate the sysfs probing in userspace.  I did that in
Debian initrd-tools 0.1.51.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
