Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267397AbRGLBI1>; Wed, 11 Jul 2001 21:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267396AbRGLBIR>; Wed, 11 Jul 2001 21:08:17 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:3333 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267394AbRGLBIF>; Wed, 11 Jul 2001 21:08:05 -0400
Message-ID: <3B4CF86E.AC11C1B@transmeta.com>
Date: Wed, 11 Jul 2001 18:07:58 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Rajeev Bector <rajeev_bector@yahoo.com>
CC: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: new IPC mechanism ideas
In-Reply-To: <20010712010204.23084.qmail@web14402.mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rajeev Bector wrote:
> 
> The point is that you can do IPC using
> this scheme which is
> 1) protected (as compared to a shared
>    memory (shm) scheme in which any process
>    can write anywhere and corrupt
>    everything)
> 
> 2) involves only 1 copy.
> 

You can still do it in user space, by having individual r/w shm mappings
to the controlling process, and ro mappings to the other processes; it's
still only one copy.

Introducing new forms of IPC adds to the complexity of the programming
model which is already too complex.  It therefore requires substandial
justification (unless you're doing it as a homework project in which case
you shouldn't be posting here), including presenting real-world
applications which cannot be properly served by current forms of IPC.

	-hpa
