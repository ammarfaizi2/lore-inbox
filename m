Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261867AbSJIPi4>; Wed, 9 Oct 2002 11:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261831AbSJIPiz>; Wed, 9 Oct 2002 11:38:55 -0400
Received: from chaos.analogic.com ([204.178.40.224]:14213 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261867AbSJIPiz>; Wed, 9 Oct 2002 11:38:55 -0400
Date: Wed, 9 Oct 2002 11:46:38 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Brian Gerst <bgerst@didntduck.org>
cc: "J.A. Magallon" <jamagallon@able.es>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Writable global section?
In-Reply-To: <3DA44603.2000708@didntduck.org>
Message-ID: <Pine.LNX.3.95.1021009114425.6928A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Brian Gerst wrote:

> Richard B. Johnson wrote:
> > I would like to be able to write to that variable and have it seen
> > by other tasks, since shared memory is shared memory. It's a shame
> > to mmap a shared library upon startup and then have to mmap some
> > additional shared memory for some inter-process communication.
> 
> There are only two ways to share memory between processes:
> - SYSV shared memory
> - using clone() to share the VM.
> 
> Shared libraries != shared memory.  Each mapping of a shared library is 
> copy-on-write.  The purpose of shared libraries is to save memory, not 
> for IPC.
> 
> --
> 				Brian Gerst

It's a shame we don't have writable global sections in shared libraries
like the old VAXen did.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

