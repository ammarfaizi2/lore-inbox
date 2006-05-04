Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750847AbWEDBin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbWEDBin (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 21:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWEDBin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 21:38:43 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:2027 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750847AbWEDBin convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 21:38:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=d7C7hXx6FCNEJ0FR7Bk+YBbrb1yCG0jdrh9kO9mlhFcKJGoRumVkhtsG4I+WzDJJOdwBP5SOzJ/C2oyuushztSIFAvSRNAuEQNdm8DpHit/SG2pPbppODtvWHMYLJk2I4N2QgqJMFTqQUcOsfKJDWCxZ7KFObr0M4pzp/cLKMTw=
Date: Thu, 4 May 2006 03:37:56 +0200
From: Diego Calleja <diegocg@gmail.com>
To: Zan Lynx <zlynx@acm.org>
Cc: wfg@mail.ustc.edu.cn, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, axboe@suse.de, nickpiggin@yahoo.com.au,
       pbadari@us.ibm.com, arjan@infradead.org
Subject: Re: [RFC] kernel facilities for cache prefetching
Message-Id: <20060504033756.f47ccd15.diegocg@gmail.com>
In-Reply-To: <1146699591.18747.23.camel@localhost>
References: <346556235.24875@ustc.edu.cn>
	<20060502144641.62df9c18.diegocg@gmail.com>
	<346580906.19175@ustc.edu.cn>
	<20060502180753.096f8777.diegocg@gmail.com>
	<346638681.24899@ustc.edu.cn>
	<20060503201413.34955426.diegocg@gmail.com>
	<1146699591.18747.23.camel@localhost>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.16; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 03 May 2006 17:39:51 -0600,
Zan Lynx <zlynx@acm.org> escribió:

> Linux should be able to do something like this using unionfs.  It could
> be worthwhile to try it with one of the very fastest flash cards or USB
> drives.

BTW; I forgot that the next intel laptops (and apparently, mactel laptops)
will have a small flash memory built in for this very purpose. According
to an article at extremetech.com, the flash memory requires an "I/O
controller"; IOW, it is not transparent and seems to need support from the
OS (although I guess that vista's "superprefetch" was designed precisely
for this hardware). Apparently, the main purpose here is to improve the
battery life (disks seeking for too many seconds can eat lot of power,
I guess). "Prefetchers" are becoming trendy, it seems

(page 14) http://www.intel.com/pressroom/kits/events/idfspr_2006/20060307_MaloneyTranscript.pdf

> With slower cards and USB keys its more of a loss unless the faster seek
> speed can make up for it, because sequential hard drive access is
> faster.

That's where the gain is; if the hard drive access was sequential people
wouldn't be talking about prefetchers. My SATA desktop drive also does
~45 MB/s, but it doesn't goes beyond 2 when seeking
