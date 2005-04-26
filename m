Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVDZQPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVDZQPL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 12:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbVDZQM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 12:12:26 -0400
Received: from [213.170.72.194] ([213.170.72.194]:10893 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S261654AbVDZQHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 12:07:17 -0400
Message-ID: <426E6731.5000703@oktetlabs.ru>
Date: Tue, 26 Apr 2005 20:07:13 +0400
From: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: "Charles P. Wright" <cwright@cs.sunysb.edu>
Cc: Jamie Lokier <jamie@shareable.org>, Ville Herva <v@iki.fi>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>	 <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com>	 <20050426134629.GU16169@viasys.com>	 <20050426141426.GC10833@mail.shareable.org> <426E4EBD.6070104@oktetlabs.ru> <1114530002.29907.21.camel@polarbear.fsl.cs.sunysb.edu>
In-Reply-To: <1114530002.29907.21.camel@polarbear.fsl.cs.sunysb.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Charles P. Wright wrote:
> Atomicity is difficult, because you have lots of caches each with their
> own bits of state (e.g., the inode/dentry caches).  Assuming your
> transaction is committed that isn't so much of a problem, but once you
> have on rollback you need to undo any changes to those caches.
I guess if you do synchronization before unlocking all is OK. Roll-back 
means deleting partially written things and restore old things, then run 
fsyncs. Whys this may be not enough?

-- 
Best regards, Artem B. Bityuckiy
Oktet Labs (St. Petersburg), Software Engineer.
+78124286709 (office) +79112449030 (mobile)
E-mail: dedekind@oktetlabs.ru, web: http://www.oktetlabs.ru
