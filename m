Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUBISCU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 13:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265320AbUBISCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 13:02:20 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:26775 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265282AbUBISCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 13:02:14 -0500
Date: Mon, 9 Feb 2004 12:57:31 -0500
From: Ben Collins <bcollins@debian.org>
To: Roland Mas <roland.mas@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS in 2.4.25-rc1 -- video1394
Message-ID: <20040209175731.GN1042@phunnypharm.org>
References: <873c9kebhw.fsf@mirexpress.internal.placard.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873c9kebhw.fsf@mirexpress.internal.placard.fr.eu.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | Trace; fcd813af <[video1394]alloc_dma_iso_ctx+1ef/5d0>
> | Trace; fcd838bf <[video1394].text.end+42a/b13>
> | Trace; fcd821c1 <[video1394]video1394_ioctl+2d1/e80>
> | 
> | Code;  fcd81136 <[video1394]free_dma_iso_ctx+b6/140>
> | 00000000 <_EIP>:
> | Code;  fcd81136 <[video1394]free_dma_iso_ctx+b6/140>   <=====
> |    0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
> | Code;  fcd81139 <[video1394]free_dma_iso_ctx+b9/140>
> |    3:   89 02                     mov    %eax,(%edx)
> | Code;  fcd8113b <[video1394]free_dma_iso_ctx+bb/140>
> |    5:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
> | Code;  fcd81142 <[video1394]free_dma_iso_ctx+c2/140>
> |    c:   c7 86 a4 00 00 00 00      movl   $0x0,0xa4(%esi)
> | Code;  fcd81149 <[video1394]free_dma_iso_ctx+c9/140>
> |   13:   00 00 00 
> | 
> | 
> | 1 warning issued.  Results may not be reliable.
> `----

Looks to me like it is failing in alloc_dma_iso_ctx(), and then calling
free_dma_iso_ctx() where it encounters some bad data. I can't see off
hand where this might happen. Was there any message prior to this, like
maybe a video1394 error message?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
