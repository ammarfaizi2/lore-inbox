Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313895AbSDJVzM>; Wed, 10 Apr 2002 17:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSDJVzL>; Wed, 10 Apr 2002 17:55:11 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:20489 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S313895AbSDJVzL>;
	Wed, 10 Apr 2002 17:55:11 -0400
Date: Wed, 10 Apr 2002 18:54:48 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: scsi_merge oops (2.5.8-pre2)
In-Reply-To: <Pine.LNX.4.33L2.0204101416350.25409-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44L.0204101853300.18660-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Apr 2002, Randy.Dunlap wrote:

> with much paging, swapping, memory pressure...
>
> [root@dev8-003 root]# kernel BUG at scsi_merge.c:82!

> so, does this mean that it's a BUG() not to be able to allocate
> with <gfp_nowait> ?

Yup, the SCSI layer crashes when RAM is really, really low.

This might be triggerable by too many incoming network
packets, if you're really unlucky.

> sounds odd to me.

After a while you'll stop wondering why the SCSI layer does things. ;)

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

