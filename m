Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263115AbREaRFS>; Thu, 31 May 2001 13:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263117AbREaRFI>; Thu, 31 May 2001 13:05:08 -0400
Received: from idiom.com ([216.240.32.1]:64526 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S263116AbREaRE5>;
	Thu, 31 May 2001 13:04:57 -0400
Message-ID: <3B16780F.D5FF04D8@namesys.com>
Date: Thu, 31 May 2001 09:57:51 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Andrej Borsenkow <Andrej.Borsenkow@mow.siemens.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: NULL characters in file on ReiserFS again.
In-Reply-To: <000201c0e9c5$7643d540$21c9ca95@mow.siemens.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrej Borsenkow wrote:
> 
> This happened to me yesterday on kernel-2.4.4-6mdk (Mandrake cooker, based
> on 2.4.4-ac14), single reiser root filesystem, mounted with default options.
> Hardware - ASUS CUSL2 (i815e chipset), Fujitsu UDMA-4 drive.
> 
> I tried to change hostname and did not have the corresponding entry in
> /etc/hosts (or anywhere). As a tesult, startx hung starting X server; it was
> not possible to switch to alpha console or kill X server. I pressed reset
> and after reboot looked into /var/log/XFree86*log - and there were a bunch
> of ^@ there.
> 
> I then run fsck from another system (installed on another partition) but
> there was no errors (well, new errors - there was off-by-one free blocks
> bitmap mismatch but it was always there, I do not know how to correct it). I
> tried the above once more but this time XFree log was O.K.
> 
> So, I really do not know how to reproduce it, but I wanted to give a warning
> that a problem still exists (albeit in emergency situation). As Reiser does
> not do any fsck after crash, the problem is serious enough IMHO.
> 
> -andrej
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
this is the nature of metadata journaling filesystems.
