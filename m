Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTJJTAJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 15:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTJJTAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 15:00:09 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:5 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S261916AbTJJTAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 15:00:06 -0400
Date: Fri, 10 Oct 2003 22:59:57 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: =?koi8-r?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Subject: Re: USB and DMA on Alpha with 2.6.0-test7
Message-ID: <20031010225957.A764@den.park.msu.ru>
References: <3F86E9D7.9020104@pacbell.net> <20031010221919.A650@den.park.msu.ru> <yw1x4qyhorsx.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <yw1x4qyhorsx.fsf@users.sourceforge.net>; from mru@users.sourceforge.net on Fri, Oct 10, 2003 at 08:45:18PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 08:45:18PM +0200, Måns Rullgård wrote:
> There was a little typo in there.  This seems to work.
...
> -	if (dma_supported (&udev->dev, 0xffffffffffffffffULL))
> +	if (*udev->dev.dma_mask == 0xffffffffffffffffULL))

Argh, what a maze of pointers ;-)
Thanks!

David, do you mind applying that?

Ivan.
