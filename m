Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbTDXRz2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 13:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263773AbTDXRz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 13:55:27 -0400
Received: from 12-207-41-15.client.attbi.com ([12.207.41.15]:40716 "EHLO
	skarpsey.home.lan") by vger.kernel.org with ESMTP id S263771AbTDXRz1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 13:55:27 -0400
From: Kelledin <kelledin+LKML@skarpsey.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: hot-swap ide disk.
Date: Thu, 24 Apr 2003 13:08:02 -0500
User-Agent: KMail/1.5.1
References: <20030424175318.GC15764@an.spylog.com>
In-Reply-To: <20030424175318.GC15764@an.spylog.com>
Cc: Andrey Nekrasov <andy@spylog.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304241308.02784.kelledin+LKML@skarpsey.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 April 2003 12:53 pm, Andrey Nekrasov wrote:
> Hello.
>
>  There is a way to give command kernel to re-read parameters
> of the hard disk (mbr/etc)?
>
>  Hard drive IDE, kernel 2.4.20, no modules support.
>
>  May be in /proc/...  ?

hdparm can unregister and re-register an entire IDE channel, at 
which point the channel gets re-scanned.  The hdparm source 
comes with an "idectl" script that makes this easy.

Don't know about individual IDE devices, though.  My 
understanding is, it's all or nothing--IDE registration applies 
to an entire channel.  Also don't know how well Linux handles 
serial ATA.

-- 
Kelledin
"If a server crashes in a server farm and no one pings it, does 
it still cost four figures to fix?"

