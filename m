Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262403AbUJ0MRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbUJ0MRo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbUJ0MRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:17:44 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:47333 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262403AbUJ0MQW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:16:22 -0400
Date: Wed, 27 Oct 2004 14:15:44 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
       trond.myklebust@fys.uio.no, neilb@cse.unsw.edu.au, torvalds@osdl.org
Subject: Re: [PATCH] NFS mount hang fix
Message-ID: <20041027121543.GH4724@fi.muni.cz>
References: <20041026141148.GM6408@fi.muni.cz> <20041026150640.GA24881@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026150640.GA24881@fieldses.org>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J. Bruce Fields wrote:
: Changing those buffers to static strikes me as potentially dangerous--we
: currently call the ->parse() methods under a semaphore, so it's safe for
: now, but that might change some day and then there'll be an ugly race
: condition.
: 
: Could you check whether the following fixes your problem?--b.
: 
	Yes, it is OK with this patch. Thanks,

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
