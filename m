Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313977AbSDKD5P>; Wed, 10 Apr 2002 23:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313978AbSDKD5O>; Wed, 10 Apr 2002 23:57:14 -0400
Received: from air-2.osdl.org ([65.201.151.6]:2831 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S313977AbSDKD5O>;
	Wed, 10 Apr 2002 23:57:14 -0400
Date: Wed, 10 Apr 2002 20:57:12 -0700 (PDT)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@osdlab.pdx.osdl.net>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch-2.5.8-pre] swapinfo accounting
In-Reply-To: <20020411014630.GK23513@matchmail.com>
Message-ID: <Pine.LNX.4.33.0204102053440.12442-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002, Mike Fedyk wrote:

| On Wed, Apr 10, 2002 at 06:20:55PM -0700, Randy.Dunlap wrote:
| > Anyway, here is the patch that makes it better.
| > Not perfect, due to possibility of bad blocks, but better
| > than it was.   Comments?
| >
| >
| > --- linux-258-pre2/mm/swapfile.c.SI	Wed Apr 10 17:50:34 2002
| > +++ linux-258-pre2/mm/swapfile.c	Wed Apr 10 18:09:46 2002
| > @@ -1107,8 +1107,8 @@
| >  			}
| >  		}
| >  	}
| > -	val->freeswap = nr_swap_pages + nr_to_be_unused;
| > -	val->totalswap = total_swap_pages + nr_to_be_unused;
| > +	val->freeswap = nr_swap_pages;
| > +	val->totalswap = total_swap_pages;
| >  	swap_list_unlock();
| >  }
|
| Shouldn't that be s/+/-/ instead?  If this is badblocks accounting, it
| should probably be subtracted instead of added.

Hi-
This isn't badblocks accounting.  Sorry for the
confusion...

[and yes, I should have looked in one of the other
kernel branches that are floating around...]

-- 
~Randy

