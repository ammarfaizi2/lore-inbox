Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262681AbSJ0V4H>; Sun, 27 Oct 2002 16:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262689AbSJ0V4H>; Sun, 27 Oct 2002 16:56:07 -0500
Received: from smtpout.mac.com ([204.179.120.85]:29400 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S262681AbSJ0V4G>;
	Sun, 27 Oct 2002 16:56:06 -0500
Message-ID: <3DBC6314.6B8AC5EA@mac.com>
Date: Sun, 27 Oct 2002 23:05:08 +0100
From: Peter Waechtler <pwaechtler@mac.com>
X-Mailer: Mozilla 4.8 [de] (X11; U; Linux 2.4.18-4GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unified SysV and Posix mqueues as FS
References: <3DBC1A6B.7020108@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul schrieb:
> 
>  > - notification not tested
>  > - still linear search in queues
> 
> Is that a problem? Receive does one linear search of the queued
> messages, send does one linear search of the waiting receivers. Both
> lists should be short.
> 

Yes, they _should_ but don't have to be.
It only matters if you ask for specific priority/type of message.

> Could you split your patch into the functional changes and cleanup?
> (const, size_t, you move a few definitions around, whitespace cleanups)
> 
> I don't like the deep integration of the mqueues into the sysv code - is
> that really needed?
> For example, you add the mqueue messages into the sysv array, and then
> add lots of code to separate both again - IPC_RMID cannot remove posix
> queues, etc.
> 
> Have you tried to separate both further? Create a ramfs like filesystem,
> store msg_queue in the inode structure?
> The ids array is only for sysv, only the actual message handling is
> shared between sysv msg and posix mqueues
> 

I plan to separate the interfaces and just share the message stuff.
But time was getting short. :)
