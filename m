Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWHHHP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWHHHP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 03:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWHHHP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 03:15:29 -0400
Received: from [82.179.117.26] ([82.179.117.26]:62143 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP
	id S1751216AbWHHHP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 03:15:28 -0400
Message-ID: <44D83A09.6020200@yandex.ru>
Date: Tue, 08 Aug 2006 11:15:21 +0400
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060501 Fedora/1.7.13-1.1.fc4
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-mtd <linux-mtd@lists.infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-rc4 jffs2 problems
References: <1154976111.17725.8.camel@localhost.localdomain>
In-Reply-To: <1154976111.17725.8.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Purdie wrote:
> JFFS2 error: (472) jffs2_get_inode_nodes: short read at 0x074e84: 68 instead of 380.
> JFFS2 error: (472) jffs2_do_read_inode_internal: cannot read nodes for ino 153, returned error is -5
> 
This looks like an MTD problem, not JFFS2.

Try to reproduce this on the mtdram flash emulator. Also, please, check 
if mtd->writesize is correct at your setup (I suppose your flash is NOR 
and it has to be 1).

-- 
Best Regards,
Artem B. Bityutskiy,
St.-Petersburg, Russia.
