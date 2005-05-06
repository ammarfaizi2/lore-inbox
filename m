Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVEFNoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVEFNoo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 09:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261187AbVEFNon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 09:44:43 -0400
Received: from [213.170.72.194] ([213.170.72.194]:56806 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261172AbVEFNoi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 09:44:38 -0400
Subject: Re: [PATCH] __wait_on_freeing_inode fix
From: "Artem B. Bityuckiy" <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dwmw2@infradead.org, akpm@osdl.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1DU32M-00068d-00@dorka.pomaz.szeredi.hu>
References: <E1DU1Hy-00060Q-00@dorka.pomaz.szeredi.hu>
	 <1115386405.16187.196.camel@hades.cambridge.redhat.com>
	 <E1DU32M-00068d-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Organization: MTD
Date: Fri, 06 May 2005 17:44:32 +0400
Message-Id: <1115387072.27158.31.camel@sauron.oktetlabs.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think it should work without Artem's patch too, since prune_icache()
> removes the inode from the hash chain at the same time (under
> inode_lock) as changing it's state to I_FREEING.  So the pruned inode
> will never be seen by iget().
> 
I suppose this doesn't mean that your patch fixes my problem (it mustn't
I believe) ?

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

