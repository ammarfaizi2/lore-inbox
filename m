Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275058AbTHQHAY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 03:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275060AbTHQHAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 03:00:24 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:44298 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S275058AbTHQHAY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 03:00:24 -0400
Date: Sun, 17 Aug 2003 08:59:54 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Erik Andersen <andersen@codepoet.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andries Brouwer <aebr@win.tue.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 5/8 Backport recent 2.6 IDE updates to 2.4.x
Message-ID: <20030817065954.GF29616@alpha.home.local>
References: <20030817061338.GF17621@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030817061338.GF17621@codepoet.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 17, 2003 at 12:13:39AM -0600, Erik Andersen wrote:

> +	printk(KERN_INFO "%s: Host Protected Area detected.\n"
> +			 "\tcurrent capacity is %ld sectors (%ld MB)\n"
> +			 "\tnative  capacity is %ld sectors (%ld MB)\n",
> +			 drive->name,
> +			 capacity, (capacity - capacity/625 + 974)/1950,
> +			 set_max, (set_max - set_max/625 + 974)/1950);

Just a question : why didn't you use your sectors_to_MB() function here, to
make this replace the unreadable hack above ?

Willy

