Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbTDTNgH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 09:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263578AbTDTNgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 09:36:07 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:23217 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S263577AbTDTNgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 09:36:06 -0400
Message-ID: <3EA2A4DD.2080809@shemesh.biz>
Date: Sun, 20 Apr 2003 16:47:09 +0300
From: Shachar Shemesh <lkml@shemesh.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Ben Collins <bcollins@debian.org>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK->CVS, kernel.bkbits.net
References: <Pine.GSO.4.21.0304201157280.14680-100000@vervain.sonytel.be>
In-Reply-To: <Pine.GSO.4.21.0304201157280.14680-100000@vervain.sonytel.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:

>On Sun, 20 Apr 2003, Shachar Shemesh wrote:
>  
>
>>The idea is that it uses the full duplexity of the channel to get client 
>>    
>>
>                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
>
>>side information about the repository on that end while downloading 
>>changes, thus increasing the effective bandwidth. It only falls back to 
>>    
>>
>
>What does this mean for asymmetric links (ADSL or cable)?
>
>Gr{oetje,eeting}s,
>
>						Geert
>  
>
ADSL is still full duplex, just not symetrical.

If I understand cvsup's operation enough, it uses the fact it 
understands what a CVS repository is to send to the server the revisions 
available for a given file. The lets the server know which parts of the 
file it needs to send back. The uplink side receives a very low 
utilization compared to the downlink side. In practice, I'm using cvsup 
for the Wine repository over an ADSL (1.5M down, I don't remeber whether 
it's 64 or 128K up), and am very pleased from it. Admitebly, I was not a 
very enthusiastic rsync convert, so I can't tell you how much faster 
cvsup is.

If you want an official benchmark, you'll have to wait a few days for my 
Wine rep. to fall out of synch. I should note the cvsup is useless if 
all your'e going to do is get the initial version. If I recall 
correctly, it actually use rsync to transfer files it cannot parse as 
CVS files, which means that initial repository retrieval should be 
equally fast with both.

-- 
Shachar Shemesh
Open Source integration consultant
Home page & resume - http://www.shemesh.biz/


