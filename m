Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314041AbSECOjR>; Fri, 3 May 2002 10:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314058AbSECOjQ>; Fri, 3 May 2002 10:39:16 -0400
Received: from jane.hollins.EDU ([192.160.94.78]:36358 "EHLO earth.hollins.edu")
	by vger.kernel.org with ESMTP id <S314041AbSECOjO>;
	Fri, 3 May 2002 10:39:14 -0400
Message-ID: <3CD2A10A.2010306@hollins.edu>
Date: Fri, 03 May 2002 10:39:06 -0400
From: "Scott A. Sibert" <kernel@hollins.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020122
X-Accept-Language: en-us
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: linux-kernel@vger.kernel.org, vt <vt@vt.fermentas.lt>,
        vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: 2.5.11 and smbfs
In-Reply-To: <Pine.LNX.4.33.0205011842001.1885-100000@cola.enlightnet.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Kernel 2.4.18 smbfs worked, 2.4.19-pre8 smbfs worked (although 
fs/ufs/super.c had some missing commas), 2.5.11 smbfs didn't work.  The 
RedHat 7.2 had samba-2.2.1a-4 so I pulled down samba-2.2.3a-4 from the 
skipjack beta and compiled it under kernel 2.5.11 and it mounts windows 
shares correctly.  I'm in the process of going to 2.5.13 but I'm going 
to stick with the 2.2.3a-4 samba.

Thanks for all of your help.

--Scott

Urban Widmark wrote:

>On Tue, 30 Apr 2002, Scott A. Sibert wrote:
>
>>I can mount other samba shares fine (ie. Samba-2.2.2 from OSX 10.1.4 and 
>>Samba-2.2.2 from Tru64 5.1) and the directories look fine.  When I mount 
>>a share from a Windows 2000 server I only get the first letter of the 
>>entry in the shared folder which, of course, makes no sense and 
>>generates errors when just trying to get an "ls" of the share.  The 
>>Win2K servers are both regular server and Adv Server, both with SP2 and 
>>the latest patches.  The linux machine is running RedHat 7.2 with almost 
>>all of the latest updates and 2.5.11 compiled.
>>
>
>The server is returning unicode filenames but smbfs isn't expecting them.
>
>You don't say which samba version your smbmount is from, but I'm guessing
>2.2.1/2.2.2. They always negotiate unicode support without knowing if
>smbfs supports it or not, which is a bug.
>
>With smbfs unicode support in 2.5 this started to matter for various
>reasons. I have thought about "autodetection" and maybe that will be
>necessary anyway.
>
>For now, upgrading samba to 2.2.3a should fix this. Let me know if it
>doesn't.
>
>/Urban
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


