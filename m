Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317083AbSGCRWd>; Wed, 3 Jul 2002 13:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSGCRWc>; Wed, 3 Jul 2002 13:22:32 -0400
Received: from chaos.analogic.com ([204.178.40.224]:10880 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S317083AbSGCRWb>; Wed, 3 Jul 2002 13:22:31 -0400
Date: Wed, 3 Jul 2002 13:25:31 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Pavel Machek <pavel@ucw.cz>
cc: "Stephen C. Tweedie" <sct@redhat.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: simple handling of module removals Re: [OKS] Module removal
In-Reply-To: <20020703034809.GI474@elf.ucw.cz>
Message-ID: <Pine.LNX.3.95.1020703132107.1629A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jul 2002, Pavel Machek wrote:

> Hi!
> 
> Okay. So we want modules and want them unload. And we want it bugfree.
> 
> So... then its okay if module unload is *slow*, right?
> 
> I believe you can just freeze_processes(), unload module [now its
> safe, you *know* noone is using that module, because all processes are
> in your refrigerator], thaw_processes().
> 
> That's going to take *lot* of time, but should be very simple and very
> effective.
> 

Absolutely. Nobody cares if it takes many milliseconds to unload a
module. We just don't want to take the 30 or more seconds necessary to
reboot the machine (3 minutes on some embedded '486es with network boots).


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

