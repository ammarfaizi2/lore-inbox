Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317211AbSFBQMN>; Sun, 2 Jun 2002 12:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317212AbSFBQMM>; Sun, 2 Jun 2002 12:12:12 -0400
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:3215 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S317211AbSFBQML>;
	Sun, 2 Jun 2002 12:12:11 -0400
Subject: Re: Need help tracing regular write activity in 5 s interval
From: Kenneth Johansson <ken@canit.se>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0206020922410.29405-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 02 Jun 2002 18:12:08 +0200
Message-Id: <1023034329.765.16.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-06-02 at 17:25, Thunder from the hill wrote:
> Hi,
> 
> > So: is there any trace software that can tell me "at 15:52:43.012345,
> > process 4321 marked 7 blocks dirty on device /dev/hda5" (or even more
> > detail so I can figure if it's just an atime update -- as with svscan --
> > or a write access)? And that is NOT to be attached to a specific process
> > (hint: strace is not an option).
> 
> Problem: we'd have to do that using printk. printk issues another write 
> call, which will mark things dirty. Issued is another printk, which marks 
> things dirty and issues another printk...
> 
> I suppose one write would become looped here?

Been there done that :) 

I turned on debug output for jffs2 without changing klog/syslog to log
to a remote machine. Did not take long for the machine to get unusable.

