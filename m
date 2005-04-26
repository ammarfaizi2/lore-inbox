Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVDZQG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVDZQG1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVDZQEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:04:38 -0400
Received: from [213.170.72.194] ([213.170.72.194]:8845 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261615AbVDZQBr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:01:47 -0400
Message-ID: <426E65E9.5070306@oktetlabs.ru>
Date: Tue, 26 Apr 2005 20:01:45 +0400
From: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       John Stoffel <john@stoffel.org>, Ville Herva <v@iki.fi>,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com> <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <20050426143247.GF10833@mail.shareable.org> <17006.22498.394169.98413@smtp.charter.net> <1114528782.13568.8.camel@lade.trondhjem.org> <20050426154708.GC14297@mail.shareable.org> <426E638B.9070704@oktetlabs.ru> <20050426155615.GE14297@mail.shareable.org>
In-Reply-To: <20050426155615.GE14297@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> No.  Why would you block?  You can have transactions without blocking
> other processes.
> 
> When updating, say, the core-utils package (which contains cat),
> there's no reason why a program which executes "cat" should have to
> block during the update.  It can simply execute the old one until the
> new one is committed at the end of the update.
> 
> It's analogous to RCU for protecting kernel data structures without
> blocking readers.
> 
Hmm, can't we implement a user-space locking system which admits of 
readers during transactions? I gues we can.

-- 
Best regards, Artem B. Bityuckiy
Oktet Labs (St. Petersburg), Software Engineer.
+78124286709 (office) +79112449030 (mobile)
E-mail: dedekind@oktetlabs.ru, web: http://www.oktetlabs.ru
