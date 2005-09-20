Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932745AbVITOLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932745AbVITOLG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 10:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932752AbVITOLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 10:11:06 -0400
Received: from [195.209.228.254] ([195.209.228.254]:49876 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S932745AbVITOLE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 10:11:04 -0400
Message-ID: <43301877.3040306@yandex.ru>
Date: Tue, 20 Sep 2005 18:11:03 +0400
From: "Artem B. Bityutskiy" <dedekind@yandex.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Peter Menzebach <pm-mtd@mw-itcon.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: data  loss on jffs2 filesystem on dataflash
References: <432812E8.2030807@mw-itcon.de> <432817FF.10307@yandex.ru> <4329251C.7050102@mw-itcon.de> <4329288B.8050909@yandex.ru> <43292AC6.40809@mw-itcon.de> <43292E16.70401@yandex.ru> <43292F91.9010302@mw-itcon.de> <432FE1EF.9000807@yandex.ru> <432FEF55.5090700@mw-itcon.de> <433006D8.4010502@yandex.ru> <20050920133244.GC4634@wohnheim.fh-wedel.de>
In-Reply-To: <20050920133244.GC4634@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> Still can't.  Block devices have the attribute that writing AAA... to
> a block containing BBB... gives you one of three possible results in
> case of power failure:
> 
> 1. BBB...BBB all written
> 2. AAA...AAA nothing written
> 3. AAA...BBB partially written.
> 
> Flash doesn't have 3, but two more cases:
> 4. FFF...FFF erased, nothing written
> 5. AAA...FFF erased, partially written
> 
> Plus the really obnoxious
> 6. FFF...FFF partially erased.  Looks fine but some bits may flip
>    randomly, writes may not stick, etc.
> 
> Now try finding a filesystem that is robust if 4-6 happens. ;)
Don't underastand this. If you mean the atomicity, CRC may help here. 
And no problems. Or may be you missed the the fact that we have 
eraseblock size = writeblock size?

>>JFFS2 orients to "classical" flashes. They have no "write page with 
>>built-in erase" operation.
> What does this thing do?
It erases individual page, then writes there. To put it differently, in 
your terminology, eraseblock size = writeblock size.

P.S. I actually missed the mailing list, this should have gone to the 
MTD ML. So let's move there please.

-- 
Best Regards,
Artem B. Bityuckiy,
St.-Petersburg, Russia.

