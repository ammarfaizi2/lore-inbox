Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317892AbSGPRIS>; Tue, 16 Jul 2002 13:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317895AbSGPRIS>; Tue, 16 Jul 2002 13:08:18 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:10001
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S317892AbSGPRIQ> convert rfc822-to-8bit; Tue, 16 Jul 2002 13:08:16 -0400
Date: Tue, 16 Jul 2002 10:07:28 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Kasper Dupont <kasperd@daimi.au.dk>
cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac5
In-Reply-To: <3D340775.7F7AAFB9@daimi.au.dk>
Message-ID: <Pine.LNX.4.10.10207161003300.6509-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The problem is not introduced by the patches, is the the hardware
decoupling the GPIO used for HOST side cable detection.  Worse is they
reused the GPIO for something else.

On Tue, 16 Jul 2002, Kasper Dupont wrote:

> DMA is still broken on the ALI15X3 IDE controller.
> Does anybody know what the problem could be
> ? The
> problem was introduced by this patch:
> 
> http://www.linuxdiskcert.org/ide-2.4.19-p8-ac1.all.convert.10.patch.bz2
> http://www.linuxdiskcert.org/ide-2.4.19-p7.all.convert.10.patch.bz2
> 
> But it is a 700K patch, without knowing a little
> more about what is going on I'd have a hard time
> finding the problem in that patch.
> 
> Symptoms are:
> - DMA does not get enabled at boot.
> - Manually switching on DMA will cause all disk
>   access to hang, the IDE led stays light until
>   IDE is initialized at next boot.
> 
> -- 
> Kasper Dupont -- der bruger for meget tid på usenet.
> For sending spam use mailto:razrep@daimi.au.dk
> or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

