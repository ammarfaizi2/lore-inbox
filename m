Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWCUTId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWCUTId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWCUTIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:08:32 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:16391 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S965044AbWCUTIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:08:31 -0500
Message-ID: <44204F25.4090403@lougher.org.uk>
Date: Tue, 21 Mar 2006 19:08:21 +0000
From: Phillip Lougher <phillip@lougher.org.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Al Viro <viro@ftp.linux.org.uk>
CC: Pavel Machek <pavel@ucw.cz>,
       "unlisted-recipients: no To-header on input <;, Jeff Garzik" 
	<jeff@garzik.org>,
       J?rn Engel <joern@wohnheim.fh-wedel.de>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [ANN] Squashfs 3.0 released
References: <B6C8687D-6543-42A1-9262-653C4D3C30B2@lougher.org.uk> <20060317104023.GA28927@wohnheim.fh-wedel.de> <C91BFAB7-C442-4EB7-8089-B55BB86EB148@lougher.org.uk> <20060317124310.GB28927@wohnheim.fh-wedel.de> <441ADD28.3090303@garzik.org> <0E3DADA8-1A1C-47C5-A3CF-F6A85FF5AFB8@lougher.org.uk> <441AF118.7000902@garzik.org> <20060319163249.GA3856@ucw.cz> <4420236F.80608@lougher.demon.co.uk> <20060321161452.GG27946@ftp.linux.org.uk>
In-Reply-To: <20060321161452.GG27946@ftp.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:

>On Tue, Mar 21, 2006 at 04:01:51PM +0000, Phillip Lougher wrote:
>  
>
>>Perhaps, but almost all the byteswap is performed on the metadata side, 
>>reading directories and inodes, where nearly every byte will need to be 
>>swapped.  As inodes are compacted and compressed in 8 KB blocks, and are 
>>on average 15 bytes in size, for each 8 KB decompress you're potentially 
>>doing 8192/15 inode byteswaps.  This is probably sufficent to affect 
>>directory search and lookup on a slow processor.
>>    
>>
>
>Oh, please...  Conversion from known endianness to host-endian is considerably
>faster than checking flag + branch + two variants, not to mention being
>smaller.
>  
>
It's one flag check, and one set of swap code actually.  The point that 
was being made is it is better to avoid byte swapping if possible.


