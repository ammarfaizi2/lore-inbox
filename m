Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWGCVH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWGCVH5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 17:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWGCVH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 17:07:57 -0400
Received: from ns1.soleranetworks.com ([70.103.108.67]:11245 "EHLO
	ns1.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932125AbWGCVH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 17:07:56 -0400
Message-ID: <44A9904F.7060207@wolfmountaingroup.com>
Date: Mon, 03 Jul 2006 15:46:55 -0600
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Tomasz Torcz <zdzichu@irc.pl>, Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>	 <20060701170729.GB8763@irc.pl>	 <20060701174716.GC24570@cip.informatik.uni-erlangen.de>	 <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no>	 <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org>
In-Reply-To: <1151960503.3108.55.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>  ZFS was already called ,,blatant layering violation''. ;)
>>Yes,that what RAID is for. And if we want checksums in filesystem,
>>that's the best way to utilise them.
>>    
>>
>
>
>Hi,
>
>checksums have a very different purpose than raid.
>
>checksums are great at detecting corruption. And yes, corruption can
>happen even if you have raid, for many many reasons. Detecting means
>knowing when to not trust something, when to go for the backup tapes...
>
>raid is great for protecting against individual disks or sectors going
>bad. But raid, especially high performance implementations, do not
>checksum data or detect corruptions. 
>
>They're different purpose with almost zero overlap in purpose or even
>goal...
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Add a salvagable file system to ext4, i.e. when a file is deleted, you 
just rename it and move it to a directory called DELETED.SAV and recycle 
the files as people allocate new ones.  Easy to do (internal "mv" of 
file to another directory) and modification of the allocation bitmaps.  
Very simple and will pay off big.  If you need help designing it, just 
ask me.

Jeff
