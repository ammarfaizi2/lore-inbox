Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270272AbTGMQbh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270273AbTGMQbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:31:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13746 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270272AbTGMQb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:31:29 -0400
Message-ID: <3F118CC6.9080906@pobox.com>
Date: Sun, 13 Jul 2003 12:45:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>
CC: Jens Axboe <axboe@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@digeo.com>,
       Andrea Arcangeli <andrea@suse.de>, Alexander Viro <viro@math.psu.edu>
Subject: Re: RFC on io-stalls patch
References: <Pine.LNX.4.55L.0307081651390.21817@freak.distro.conectiva>	 <20030710135747.GT825@suse.de> <1057932804.13313.58.camel@tiny.suse.com>	 <20030712073710.GK843@suse.de> <1058034751.13318.95.camel@tiny.suse.com>	 <20030713090116.GU843@suse.de> <1058113238.13313.127.camel@tiny.suse.com>
In-Reply-To: <1058113238.13313.127.camel@tiny.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> Well, I'd say it's a more common problem to have lots of writes, but it
> is pretty easy to fill the queue with reads.

Well....

* you will usually have more reads than writes
* reads are more dependent than writes, on the whole
* writes are larger due to delays and merging

All this is obviously workload dependent, but it seems like the 60% 
common case, at least...

Basically when I hear people talking about lots of writes, that seems to 
be downplaying the fact that seeing 20 writes and 2 reads on a queue 
does not take into account the userspace applications currently 
blocking, waiting to do another read.

	Jeff



