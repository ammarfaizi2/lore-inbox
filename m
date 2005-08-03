Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVHCBp2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVHCBp2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 21:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261961AbVHCBp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 21:45:28 -0400
Received: from rwcrmhc12.comcast.net ([204.127.198.43]:19177 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261951AbVHCBpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 21:45:25 -0400
Message-ID: <42F01712.2030105@namesys.com>
Date: Tue, 02 Aug 2005 18:00:02 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       David Teigland <teigland@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
References: <20050802071828.GA11217@redhat.com>	 <1122968724.3247.22.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.61.0508021655580.4138@yvahk01.tjqt.qr> <1122994972.3247.31.camel@laptopd505.fenrus.org>
In-Reply-To: <1122994972.3247.31.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>On Tue, 2005-08-02 at 16:57 +0200, Jan Engelhardt wrote:
>  
>
>>>* Why use your own journalling layer and not say ... jbd ?
>>>      
>>>
>>Why does reiser use its own journalling layer and not say ... jbd ?
>>    
>>
>
>because reiser got merged before jbd. Next question.
>  
>
That is the wrong reason.  We use our own journaling layer for the
reason that Vivaldi used his own melody.

I don't know anything about GFS, but expecting a filesystem author to
use a journaling layer he does not want to is a bit arrogant.  Now, if
you got into details, and said jbd does X, Y and Z, and GFS does the
same X and Y, and does not do Z as well as jbd, that would be a more
serious comment.  He might want to look at how reiser4 does wandering
logs instead of using jbd..... but I would never claim that for sure
some other author should be expected to use it.....  and something like
changing one's journaling system is not something to do just before a
merge.....

>Now the question for GFS is still a valid one; there might be reasons to
>not use it (which is fair enough) but if there's no real reason then
>using jdb sounds a lot better given it's maturity (and it is used by 2
>filesystems in -mm already).
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

