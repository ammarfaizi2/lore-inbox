Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271365AbTHHPXo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271378AbTHHPXo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:23:44 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:63135 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S271365AbTHHPXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:23:43 -0400
Date: Fri, 8 Aug 2003 08:23:37 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Initrd problem with 2.6 kernel
Message-ID: <20030808152337.GA11088@lucon.org>
References: <20030807223019.GA27359@lucon.org> <E19l4o8-0001Jv-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19l4o8-0001Jv-00@gondolin.me.apana.org.au>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08, 2003 at 08:49:16PM +1000, Herbert Xu wrote:
> H. J. Lu <hjl@lucon.org> wrote:
> > There is a chicken and egg problem with initrd on 2.6. When
> > root=/dev/xxx is passed to kernel, kernel will call try_name, which
> > uses /sys/block/drive/dev, to find out the device number for ROOT_DEV.
> > The problem is /sys/block/drive may not exist if the driver is loaded
> > by /linuxrc in initrd. As the result, /linuxrc can't use
> > /proc/sys/kernel/real-root-dev to determine the root device number.
> 
> You can replicate the sysfs probing in userspace.  I did that in
> Debian initrd-tools 0.1.51.

It sounds a good idea. I will give it a try.

Thanks.

H.J.
