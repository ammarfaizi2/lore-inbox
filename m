Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319113AbSHFMtk>; Tue, 6 Aug 2002 08:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319110AbSHFMs3>; Tue, 6 Aug 2002 08:48:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:17672 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S319112AbSHFMr6>; Tue, 6 Aug 2002 08:47:58 -0400
Message-ID: <3D4C23E6.8020503@evision.ag>
Date: Sat, 03 Aug 2002 20:41:42 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Jens Axboe <axboe@suse.de>, martin@dalecki.de, Stephen Lord <lord@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A new ide warning message
References: <Pine.SOL.4.30.0208021513490.3612-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Bartlomiej Zolnierkiewicz napisa?:

> Look again Jens. Adam's changes made IDE queue handling inconsistent.
> hint: 2 * 127 != 255
> 
> But noticed warning deals with design of ll_rw_blk.c. ;-)
> (right now max_segment_size have to be max bv->bv_len aligned)
> 
> Jens, please look at segment checking/counting code, it does it on
> bv->bv_len (4kb most likely) not sector granuality...
> 
> So for not 4kb aligned max_segment_size we will get new segment...
> 
> Best fix will be to make block layer count sectors not bv->bv_len...
> 
> 
> btw. I like Adam's patch but it was draft not to include in mainline (?).

One never ever get's anything then drafts from Adam ;-) And since
I can't reproducde the breakage myself on any system I test
and since the patch looked really smooth...
Ej ej...


