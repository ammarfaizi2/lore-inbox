Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290010AbSAKTeJ>; Fri, 11 Jan 2002 14:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290021AbSAKTds>; Fri, 11 Jan 2002 14:33:48 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:27149 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S290010AbSAKTdp>; Fri, 11 Jan 2002 14:33:45 -0500
Message-ID: <3C3F3D4B.6060605@namesys.com>
Date: Fri, 11 Jan 2002 22:30:19 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: "W. Wilson Ho" <ho@routefree.com>, "Gryaznova E." <grev@namesys.botik.ru>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: [reiserfs-list] Re: elevator algorithm in disk controller bad?
In-Reply-To: <Pine.LNX.4.10.10201110157240.9366-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:

>You mean like this ??
>
>ide.2.4.0-ac10.all.01212001.patch:
>+static int do_flush_cache(ide_drive_t *drive);
>ide.2.4.0-ac10.all.01212001.patch:
>+ (do_flush_cache(drive)) ? "SUCCESSED" : "FAILED");
>ide.2.4.0-ac10.all.01212001.patch:
>+static int do_flush_cache (ide_drive_t *drive)
>ide.2.4.0-ac10.all.01212001.patch:
>+ (do_flush_cache(drive)) ? "SUCCESSED" : "FAILED");
>ide.2.4.0-ac10.all.01212001.patch:
>-              * all current requests to be flushed from the queue.
>ide.2.4.0-ac10.all.01212001.patch:
>+      * all current requests to be flushed from the queue.
>
>Or something more up to date?
>
>ide.2.4.16.12102001.patch:+     flushcache:             NULL,
>ide.2.4.16.12102001.patch:+static int do_idedisk_flushcache(ide_drive_t *drive);
>ide.2.4.16.12102001.patch:+             if (do_idedisk_flushcache(drive))
>ide.2.4.16.12102001.patch:+static int do_idedisk_flushcache (ide_drive_t *drive)
>ide.2.4.16.12102001.patch:+             if (do_idedisk_flushcache(drive))
>ide.2.4.16.12102001.patch:+     flushcache:             do_idedisk_flushcache,
>ide.2.4.16.12102001.patch:+     flushcache:             NULL,
>ide.2.4.16.12102001.patch:+     flushcache:             NULL,
>
> On Fri, 11 Jan 2002, Hans Reiser wrote:
>
>>Andre, have you had a chance to put in the the cache flushing stuff into 
>>your IDE code?
>>
>>Hans
>>
>
><snip>
>
>This code as only been available for a year or so ...
>
>Regards,
>
>Andre Hedrick
>Linux ATA Development
>
>
>

Your code has been kept out of the main kernel for a year or so?  Sigh. 
 I guess 2.4 has been freezing (except for VFS and MM which I will say 
nothing about) for that long....

Chris and Edward, can you look at it and create a complementary patch to 
make use of it that we can ask Andre to add to his patch, and then link 
to his patch on our website?

Hans

