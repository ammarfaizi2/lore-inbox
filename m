Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263294AbTIAVSg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 17:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbTIAVSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 17:18:36 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:11244 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263294AbTIAVSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 17:18:32 -0400
Message-ID: <3F53550E.8030708@myrealbox.com>
Date: Mon, 01 Sep 2003 07:17:50 -0700
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030805
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: More on Broadcom gigbit for Jeff
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

I've narrowed down the source of my Broadcom problem to the 'tg3.c + tg3.h'
portions of this patch:

ftp://ftp.kernel.org/pub/linux/kernel/v2.4/testing/incr/patch-2.4.21-pre4-pre5.gz

That is, if I build a 2.4.21-pre4 kernel it works normally -- but if I then apply
just the tg3.c parts of the above patch I get my usual bug.

(If you'll recall, I'm the one who needs to do an ifconfig down/up cycle on my
ASUS A7V8X mobo with the built-in tg3 chip before it will start transmitting
packets.)

Unfortunately this patch has many changes that I don't understand well enough so
that I can cull them out and apply them individually.

Is it reasonable to try to do break this patch down into pieces?  It all looks
like one big update to me.

Any other debugging ideas?

Thanks.

