Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVDRM5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVDRM5g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 08:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVDRM5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 08:57:30 -0400
Received: from [213.170.72.194] ([213.170.72.194]:44703 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S262068AbVDRM5O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 08:57:14 -0400
Message-ID: <4263AE96.5080707@yandex.ru>
Date: Mon, 18 Apr 2005 16:56:54 +0400
From: "Artem B. Bityuckiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: "Artem B. Bityuckiy" <dedekind@infradead.org>,
       linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
       dwmw2@lists.infradead.org
Subject: Re: [PATC] small VFS change for JFFS2
References: <1113814031.31595.3.camel@sauron.oktetlabs.ru> <20050418085121.GA19091@infradead.org> <1113814730.31595.6.camel@sauron.oktetlabs.ru> <20050418105301.GA21878@infradead.org> <1113824781.2125.12.camel@sauron.oktetlabs.ru> <20050418115220.GA22750@infradead.org> <1113827466.2125.47.camel@sauron.oktetlabs.ru> <20050418124656.GA23387@infradead.org>
In-Reply-To: <20050418124656.GA23387@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> Why doesn't __wait_on_freeing_inode get called? prune_icache sets I_FREEING
> before it's dropping the inode lock.
I suppose because the inode is *deleted* from i_hash. But 
find_inode_fast looks for inode using *->i_hash*. Of course it will not 
find anything and call read_inode() immediately. Did I miss something?

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.
