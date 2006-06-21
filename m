Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbWFUE4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbWFUE4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 00:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWFUE4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 00:56:40 -0400
Received: from mail06.syd.optusnet.com.au ([211.29.132.187]:61165 "EHLO
	mail06.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750791AbWFUE4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 00:56:39 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [ckpatch][15/29] hz-no_default_250.patch
Date: Wed, 21 Jun 2006 14:53:09 +1000
User-Agent: KMail/1.9.1
Cc: Albert Cahalan <acahalan@gmail.com>, linux-kernel@vger.kernel.org
References: <787b0d920606181752j4b7c7309t9c0ab9bf8da1537a@mail.gmail.com> <200606191125.50826.kernel@kolivas.org> <Pine.LNX.4.61.0606191351350.31576@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0606191351350.31576@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606211453.10239.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 21:52, Jan Engelhardt wrote:
> >Yes I stored a family of these values and 864 was ~ the optimum for a high
> >value for desktops and ~84 for a low value but were unpopular for not
> > being
>
> 82 IIRC.

Ah yes here it is

    HZ   ticks/jiffie  1 second      error (ppm)
---------------------------------------------------
    82      14551      1.000000152       0.2
    96      12429      1.000001829       1.8
   209       5709      0.999999314      -0.7
   363       3287      0.999999314      -0.7
   519       2299      0.999999314      -0.7
   864       1381      1.000001829       1.8

>
> >something decimally familiar. Also lots of code kind of broke with values
> >below 100 in the kernel.
>
> Ought to be fixed. Just like the code which assumed 100 Hz and broke during
> the initial switch to 1000, before we went back again to 250. :p

No impetus to fix them I guess since there is no way to configure the kernel 
for sub 100 HZ configs without hacking it.

-- 
-ck
