Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTKIKrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 05:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbTKIKrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 05:47:09 -0500
Received: from pop.gmx.de ([213.165.64.20]:17836 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262352AbTKIKrF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 05:47:05 -0500
X-Authenticated: #4512188
Message-ID: <3FAE1BB7.5090203@gmx.de>
Date: Sun, 09 Nov 2003 11:49:27 +0100
From: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031102
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
References: <3FA69CDF.5070908@gmx.de> <3FA8C916.3060702@gmx.de> <20031105095457.GG1477@suse.de> <3FA8CA87.2070201@gmx.de> <boe68a$f3g$1@gatekeeper.tmr.com> <3FAAB8B5.6060901@gmx.de> <3FAABFBF.3040300@gmx.de> <20031107210535.GA445@suse.de>
In-Reply-To: <20031107210535.GA445@suse.de>
X-Enigmail-Version: 0.76.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Thu, Nov 06 2003, Prakash K. Cheemplavam wrote:
> 
>>Prakash K. Cheemplavam wrote:
>>
>>>bill davidsen wrote:
>>>
>>>
>>>>In article <3FA8CA87.2070201@gmx.de>,
>>>>Prakash K. Cheemplavam <prakashkc@gmx.de> wrote:
>>>>
>>>>| Sorry, I wasn't precise: The data is on the disc, as my DVD-ROM 
>>>>restores | the full image (md5sum matches), but the CD-RW does not.
>>>>
>>>>There is a problem with ide-scsi in 2.6, and rather than fix it someone
>>>>came up with a patch to cdrecord to allow that application to work
>>
>>>b) The writing or reading issue mentioned above. It is a bit hard to 
>>>find out, whether cdrecord actually *writes* an incomplete image 
>>>(without using -pad), ie. throwing away the last 4096 bytes, which 
>>>*only* happens in non-TAO mode. The programme CDRDAO shows the same 
>>>behaviour. Strange enough reading this DAO written image out with my 
>>>DVD-ROM makes this (missing?) 4096 bytes reappear... Well, maybe I 
>>>should patch the image and put some other bytes instead of the 00s at 
>>>the end to see, whether it is a write issue, a read issue of the writer 
>>>or a read issue of the reader. Anyway, it doesn't sound right to me, 
>>>what is happening at the moment...
>>
>>So tested further: I patched the very last byts of the image and these 
>>are my findings:
>>
>>In DAO mode, the complete image is actually written, but the writer is 
>>not able to read it out! The last 4096 bytes are not read. I put the 
>>CD-RW into my DVD-ROM, and it reads it out completely.
>>
>>So: Is cdrecord/cdrdao making something wrong (yes, I know I can use 
>>-pad, but I want an *identical copy*) or has the kernel ATAPI reading 
>>routine a bug? (Or has my drive a bug???? Well, I need to read the disc 
>>out in windows I guess...)
> 
> 
> See one of my mails from a few days ago. It's a hardware issue, some
> drives need a bit of pad at the end.

Yup, I verified it in windows. Same issue, so it is a hardware and not 
software issue.

Prakash



-- 
=-----=
|=-P-=|
=-----=

