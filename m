Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264565AbTLVXIV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264568AbTLVXIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:08:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22434 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264565AbTLVXIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:08:19 -0500
Message-ID: <3FE7794D.7000908@pobox.com>
Date: Mon, 22 Dec 2003 18:07:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Joe Thornber <thornber@sistina.com>
Subject: Re: [PATCH 2/2][RFC] Add dm-crypt target
References: <1072129379.5570.73.camel@leto.cs.pocnet.net> <20031222215236.GB13103@leto.cs.pocnet.net>
In-Reply-To: <20031222215236.GB13103@leto.cs.pocnet.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> Hi,
> 
> this is the actual dm-crypt target. It uses cryptoapi to achive the same
> goal as cryptoloop.
> 
> It uses mempools to ensure not to ever run out of memory and can split
> large IOs into smaller ones under memory pressure.
> 
> Tested by some people, also works on a swap device.


I like this.   Nice and clean.

May I assume that this is -not- intended as a replacement for 
cryptoloop?  I hope so, as that would be my recommendation:  new driver, 
new on-disk format.

cryptoloop predates block layer stacking, and also support files, so I 
would prefer to emphasize their differences.  A replacement for 
cryptoloop means you must support cryptoloop's on-disk format.

	Jeff



