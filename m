Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbUBHDel (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 22:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUBHDek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 22:34:40 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:42957 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262055AbUBHDej (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 22:34:39 -0500
Message-ID: <4025AE98.3090601@myrealbox.com>
Date: Sat, 07 Feb 2004 19:35:52 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040207
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1] Kernel panic with ppa driver updates
References: <fa.db71fu4.1gju7jo@ifi.uio.no> <fa.n1cha2m.1hhep3a@ifi.uio.no>
In-Reply-To: <fa.n1cha2m.1hhep3a@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

> Very interesting...  Could you add
> 	printk("dev = %p, dev->cur_cmd = %p\n", dev, dev->cur_cmd);
> right before the call of ppa_pb_claim() call in __ppa_attach(), the
> same - right before if (dev->wanted) in the same function and
> 	printk("dev = %p, dev->cur_cmd set to %p\n", dev, dev->cur_cmd);
> right after dev->cur_cmd = cmd; in ppa_queuecommand()?

Only one of the print statements was executed, apparently:

ppa: Version 2.07 (for Linux 2.4.x)
dev = dfd67940, dev->cur_cmd = 7232b2df
Unable to handle kernel paging request at virtual address 7232b403
  printing eip:
c027bc25

The remainder of the message was identical to the previous post -- no
extra printed messages anywhere.
