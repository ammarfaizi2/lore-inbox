Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288531AbSA2Crp>; Mon, 28 Jan 2002 21:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288566AbSA2Crf>; Mon, 28 Jan 2002 21:47:35 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:12555 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288531AbSA2CrY>; Mon, 28 Jan 2002 21:47:24 -0500
Message-ID: <3C560D33.5020608@redhat.com>
Date: Mon, 28 Jan 2002 21:47:15 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Neale Banks <neale@lowendale.com.au>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] i810 driver update.
In-Reply-To: <Pine.LNX.4.05.10201291348590.1513-100000@marina.lowendale.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neale Banks wrote:
> On Mon, 28 Jan 2002, Doug Ledford wrote:
> 
> [...]
> 
>>>Are the fixes in this going to be applicable to 2.2 also (FWIW, 2.2's
>>>i810_audio #defines ``DRIVER_VERSION "0.17"'')?
>>>
>>
>>I'm sure the fixes are relevant.  How well they may integrate into 2.2 is 
>>another question :-/
>>
> 
> Indeed ;-)  Alan?
> [...]
> 
>>The best I can do it to make a diff between the 0.17 driver version I have 
>>here and the 0.21 driver version.  Maybe that incremental diff will apply to 
>>the 2.2 kernel's i810_audio.c and bring it up to date without any specific 
>>back port needed.  It's attached.
>>
> 
> Thanks anyway, but it doesn't look too hopeful (patch complaints
> appended).  I suspect your "0.17" and 2.2's "0.17" may not be the same
> thing (in 2.2.21pre2 i810_audio.c is 51877 bytes and "sum (GNU textutils)  
> 2.0" reports "44467 51"
> 
> Regards,
> Neale.
> 
> $ patch --dry-run < 2.2-i810.patch 
> patching file `i810_audio.c.17'
> Hunk #1 succeeded at 181 (offset -25 lines).
> Hunk #2 FAILED at 576.
> Hunk #3 FAILED at 653.
> Hunk #4 FAILED at 1107.
> Hunk #5 FAILED at 1117.
> Hunk #6 FAILED at 1138.
> Hunk #7 FAILED at 1169.
> Hunk #8 succeeded at 1127 with fuzz 1 (offset -248 lines).
> Hunk #9 FAILED at 1278.
> Hunk #10 FAILED at 1492.
> Hunk #11 FAILED at 2175.
> Hunk #12 FAILED at 2877.
> 10 out of 12 hunks FAILED -- saving rejects to i810_audio.c.17.rej
> 
> 

Yeah, there's a vast difference there.  I would guess that the difference is 
the presence of S/PDIF support in the 2.4+ .17 driver version and none in 
the 2.2 version.  Email me the whole 0.17 file you have there (off-list) and 
I'll see about integrating the changes.


-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

