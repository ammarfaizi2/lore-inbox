Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWCUPSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWCUPSq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 10:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751770AbWCUPSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 10:18:46 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:28896 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751768AbWCUPSq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 10:18:46 -0500
Message-ID: <4420195B.10707@cfl.rr.com>
Date: Tue, 21 Mar 2006 10:18:51 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Yaroslav Rastrigin <yarick@it-territory.ru>
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: VFAT: Can't create file named 'aux.h'?
References: <1142890822.5007.18.camel@localhost.localdomain> <Pine.LNX.4.61.0603202244370.11933@yvahk01.tjqt.qr> <200603210849.20224.yarick@it-territory.ru>
In-Reply-To: <200603210849.20224.yarick@it-territory.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2006 15:18:54.0248 (UTC) FILETIME=[C41E1A80:01C64CFA]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.52.1006-14337.000
X-TM-AS-Result: No--12.300000-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I disagree with this philosophy seeing as how it is possible to create 
these files from within windows itself:

echo foo > \\?\c:\aux.h
dir *.h
  Volume in drive C has no label.
  Volume Serial Number is F064-30D6

  Directory of C:\

03/21/2006  10:07a                   6 aux.h
                1 File(s)              6 bytes
                0 Dir(s)   4,584,951,808 bytes free

Creates a file named aux.h in c:\ just fine.  Under win2k at least, 
explorer only hangs when I try to click on the file.  Explorer has 
always done really stupid things like this though.  I remember when 95 
first came out we could create files with high ascii names on the server 
like ascii 255, and explorer would happily render it as an underscore 
(_), but could not open it or delete it because it was actually trying 
to access a directory named "_" rather than ascii 255.

Just because explorer/the win32 api is stupid doesn't mean linux should 
be too.

Yaroslav Rastrigin wrote:
>> It seems only fair to me to not allow creating these files under Linux 
>> either, to avoid problems when booting back to Dos/Windows.
> This is true. smbfs, OTOH, has no such checks, so creating aux.h on an smb share is one easy way to DoS 
> all WinXP machines using(browsing) this share. Explorer hangs on reading directory with this file.
>>
>> Jan Engelhardt
> 

