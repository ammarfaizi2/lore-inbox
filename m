Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271329AbRHTQOD>; Mon, 20 Aug 2001 12:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271321AbRHTQNx>; Mon, 20 Aug 2001 12:13:53 -0400
Received: from panther.noc.ucla.edu ([169.232.10.21]:8179 "EHLO
	panther.noc.ucla.edu") by vger.kernel.org with ESMTP
	id <S271320AbRHTQNr>; Mon, 20 Aug 2001 12:13:47 -0400
Message-ID: <3B813743.5080400@ucla.edu>
Date: Mon, 20 Aug 2001 09:13:55 -0700
From: Benjamin Redelings I <bredelin@ucla.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3+) Gecko/20010813
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.4.8/2.4.9 VM problems
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> Could you please try this patch against 2.4.9 (patch -p0):
> 
> --- ../2.4.9.clean/mm/memory.c	Mon Aug 13 19:16:41 2001
> +++ ./mm/memory.c	Sun Aug 19 21:35:26 2001
> @@ -1119,6 +1119,7 @@
>  			 */
>  			return pte_same(*page_table, orig_pte) ? -1 : 1;
>  		}
> +		SetPageReferenced(page);
>  	}
>  
>  	/*
> 


Well, I tried this, and.... WOW!  Much better  [:)]
Was it really true, that swapped in pages didn't get marked as 
referenced before?  It almost felt that bad, but that seems kind of 
crazy - I don't completely understand what this fix is doing...

-BenRI
P.S. I tried this on my 64Mb PPro and a 128Mb PIII, and both felt like 
they had a lot more memory - e.g. less swapping and stuff.
-- 
"I will begin again" - U2, 'New Year's Day'
Benjamin Redelings I      <><     http://www.bol.ucla.edu/~bredelin/

