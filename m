Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbUBCPAc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 10:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbUBCPAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 10:00:31 -0500
Received: from smtp.dkm.cz ([62.24.64.34]:266 "HELO smtp.dkm.cz")
	by vger.kernel.org with SMTP id S261928AbUBCPA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 10:00:29 -0500
Message-ID: <401FB78A.5010902@zvala.cz>
Date: Tue, 03 Feb 2004 16:00:26 +0100
From: Tomas Zvala <tomas@zvala.cz>
User-Agent: Mozilla Thunderbird 0.5a (20031223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0, cdrom still showing directories after being erased
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos>
In-Reply-To: <Pine.LNX.4.53.0402030839380.31203@chaos>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I believe he meant to write he umounted it.
The problem is that there is still some data left in CDRW's cache and it 
needs to be emptied. That happens when CDRW is ejected and reinserted 
(that is why windows burning software ie. Nero wants to eject the CDR/RW 
when it gets written or erased).
Maybe kernel could flush the buffers/caches or whatever is there when 
CDROM gets mounted. But im afraid about compatibility with broken drives 
such as LG.

Tomas Zvala

Richard B. Johnson wrote:

>On Tue, 3 Feb 2004, Martin [iso-8859-2] Povolný wrote:
>
>  
>
>>I have debian's 2.6.0-686-smp only with PNP BIOS disabled (fails to
>>boot with enabled, as described by other people).
>>
>>I did
>>
>>$ mount /cdrom/
>>$ ls /cdrom/
>>
>>got listing of files and directories on the cdrom
>>then
>>
>>$ cdrecord dev=/dev/hdc -blank=fast -v
>>...
>>Blanking time:   21.570s
>>$ mount /cdrom
>>$ ls /cdrom
>>    
>>
>
>Can you really initialize the CDROM while it's mounted? Although
>the kernel doesn't care, cdrecord should. Suggest that you
>contact the cdrecord author.
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
>            Note 96.31% of all statistics are fiction.
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
