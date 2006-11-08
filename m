Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWKHUx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWKHUx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 15:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932676AbWKHUx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 15:53:29 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:25737 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932138AbWKHUx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 15:53:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eg9Cnoh59MxMvMT6MMh5rCRlrAIrNfVeP2u0hSJkQL3wono3vBbI+wQv1V9MJNJWsNTD70c+ksu89hXXUDtmind2ZrukOqBqzjFUMY+aQJLvhE3B+hI/ksOzU7DkgcAko+W2QMAkwqP1YR1RBLZkL5DwnK8LSpkTsd12Pq3wO7Q=
Message-ID: <9a8748490611081253y29eeda5fv69fb6109d9ac0867@mail.gmail.com>
Date: Wed, 8 Nov 2006 21:53:25 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: Stephen.Clark@seclark.us
Subject: Re: New laptop - problems with linux
Cc: "Stephen Hemminger" <shemminger@osdl.org>,
       "Francois Romieu" <romieu@fr.zoreil.com>,
       "Jiri Slaby" <jirislaby@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Dave Jones" <davej@redhat.com>, netdev@vger.kernel.org
In-Reply-To: <45523F3F.8010806@seclark.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4551EC86.5010600@seclark.us> <4551F3A6.8040807@gmail.com>
	 <4551F5B7.1050709@seclark.us>
	 <20061108182658.GA21154@electric-eye.fr.zoreil.com>
	 <45523289.2010002@seclark.us> <20061108122649.2f79ec1f@freekitty>
	 <45523F3F.8010806@seclark.us>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/06, Stephen Clark <Stephen.Clark@seclark.us> wrote:
> Stephen Hemminger wrote:
>
> >On Wed, 08 Nov 2006 14:39:53 -0500
> >Stephen Clark <Stephen.Clark@seclark.us> wrote:
> >
> >
> >>03:00.0 Network controller: Intel Corporation PRO/Wireless 3945ABG
> >>Network Connection (rev 02)
> >>        Subsystem: Intel Corporation Unknown device 1000
> >>
> >>
> >>
> >
> >Use the ipw3945 driver and binary regulatory daemon from:
> >       http://ipw3945.sourceforge.net/#downloads
> >
> >
> Thanks I have that working - I am now struggling with the disk being
> slower than molasses ( high priority, 1.xx mb/sec  ) and the integrated
> realtek ethernet
> ( low prioirty - since I got the wifi working ).
>
As Stephen Hemminger wrote, getting your realtek card working should
be a simple matter of either backporting the recent change that adds
its PCI ID or simply run a 2.6.19-rc5 kernel that includes it.


> >>05:07.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169SC
> >>Gigabit Ethernet (rev 10)
> >>        Subsystem: ASUSTeK Computer Inc. Unknown device 1345
> >>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
> >>ParErr- Stepping- SERR- FastB2B-
> >>        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
> >><TAbort- <MAbort- >SERR- <PERR-
> >>        Latency: 64 (8000ns min, 16000ns max), Cache Line Size: 32 bytes
> >>        Interrupt: pin A routed to IRQ 11
> >>        Region 0: I/O ports at d800 [size=256]
> >>        Region 1: Memory at fe8ffc00 (32-bit, non-prefetchable) [size=256]
> >>        Expansion ROM at 80000000 [disabled] [size=128K]
> >>        Capabilities: [dc] Power Management version 2
> >>                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
> >>PME(D0-,D1+,D2+,D3hot+,D3cold+)
> >>                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> >>00: ec 10 67 81 17 00 b0 02 10 00 00 02 08 40 00 00
> >>10: 01 d8 00 00 00 fc 8f fe 00 00 00 00 00 00 00 00
> >>20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 45 13
> >>30: 00 00 8c fe dc 00 00 00 00 00 00 00 0b 01 20 40
> >>
> >>
> >>
> >
> >This PCI ID was added to 2.6.19.  You should run 2.6.19-rc5 or backport the changes.
> >

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
