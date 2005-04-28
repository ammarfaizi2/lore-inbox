Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261772AbVD1IkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261772AbVD1IkE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 04:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVD1Igr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 04:36:47 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:61208 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261868AbVD1IWg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 04:22:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HOpNae918TgJIXD8dgMgnX0Cfg7aLoocHBRXMTsDhha0MbZzF89GA3ygiwaZGcIrOozPlztNO78/bnotKm5wrbTfG2yC93xL/CKrVtGXCfw0zQy+uTNBiypfFdvnZ9zje4n+UmBiRbuKLxhPMUh4k2ElbHlTRc4UVehWatfNNGU=
Message-ID: <21d7e99705042801227ed5438e@mail.gmail.com>
Date: Thu, 28 Apr 2005 09:22:36 +0100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: ryantemporary@gmail.com
Subject: Re: DRI lockup on R200, 2.6.11.7
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
In-Reply-To: <20050426202916.GA2635@xarello>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050426202916.GA2635@xarello>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/05, foo@porto.bmb.uga.edu <foo@porto.bmb.uga.edu> wrote:
> Using 2.6.11.7, I'm experiencing the same problem as reported here:
> http://lkml.org/lkml/2005/3/12/99
> 
> Except it happens for me after X is running.  X locks up, only the mouse
> pointer moves, X spins doing this:
> 
> --- SIGALRM (Alarm clock) @ 0 (0) ---
> rt_sigreturn(0xe)                       = -1 EBUSY (Device or resource busy)
> ioctl(5, 0x6444, 0)                     = -1 EBUSY (Device or resource busy)
> ioctl(5, 0x6444, 0)                     = -1 EBUSY (Device or resource busy)
> 
> Killing X causes the machine to reset shortly thereafter.  I've seen
> this on ATI Radeon 9200s and 9000 Pros.  X is version 4.3.0.dfsg.1-12.
> 

2.6.12 should fix this, there is patch at:
http://drm.bkbits.net:8080/drm-linus/gnupatch@424260f9PBUdlFvyiQw1maJBKvEtXA

Dave.
