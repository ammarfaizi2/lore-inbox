Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUJTOcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUJTOcu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 10:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268439AbUJTOb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 10:31:28 -0400
Received: from webapps.arcom.com ([194.200.159.168]:62478 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S268594AbUJTO3w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:29:52 -0400
Subject: Re: Strange! Cannot use JFFS2 as root
From: Ian Campbell <icampbell@arcom.com>
To: colin <colin@realtek.com.tw>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <002101c4b6ad$9fe6d880$8b1a13ac@realtek.com.tw>
References: <002101c4b6ad$9fe6d880$8b1a13ac@realtek.com.tw>
Content-Type: text/plain
Organization: Arcom Control Systems
Message-Id: <1098282591.29412.1706.camel@icampbell-debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 15:29:51 +0100
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Oct 2004 14:30:04.0171 (UTC) FILETIME=[4A1715B0:01C4B6B1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I traced the code and found that when passing "/dev/mtdblock1" to
> name_to_dev_t() in do_mounts.c, it would return 0 at every try_name(), which
> will fail at open() with the path "/sys/block/%s/dev".
> 
> What's the problem? Could anyone tell me?

If I remember correctly you need to pass the root in as the major and
minor numbers for jffs2 on 2.6. For example my 2.6 command line is
	root=31:03 rootfstype=jffs2 ro console=ttyS0,115200
rather that root=/dev/mtdblock3.

I can't remember why this is the case though.

Ian.
-- 
Ian Campbell, Senior Design Engineer
                                        Web: http://www.arcom.com
Arcom, Clifton Road, 			Direct: +44 (0)1223 403 465
Cambridge CB1 7EA, United Kingdom	Phone:  +44 (0)1223 411 200

