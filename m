Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276840AbRJQNyC>; Wed, 17 Oct 2001 09:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276857AbRJQNxt>; Wed, 17 Oct 2001 09:53:49 -0400
Received: from 24-216-84-59.hsacorp.net ([24.216.84.59]:47854 "EHLO
	pogo.plainjoe.org") by vger.kernel.org with ESMTP
	id <S276836AbRJQNxn>; Wed, 17 Oct 2001 09:53:43 -0400
Date: Wed, 17 Oct 2001 08:56:18 -0500 (CDT)
From: "Gerald (Jerry) Carter" <jerry@samba.org>
X-X-Sender: <jerry@pogo.plainjoe.org>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Creating files on Samba got weird
In-Reply-To: <5913527831.20011016122411@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33.0110170854300.4049-100000@pogo.plainjoe.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2001, vda wrote:

> (CC'ing to lkml in hope on advise why I've got ksymoops error)
>
> Hello Urban,
>
> My Samba server behaves strangely.
> Very frequently (but not always) when I try to create/copy
> files from win box to linux samba server it says that file/dir
> already exists or that connection terminated. It is indeed exists,
> in case of a file it is of zero length. Subsequent copy with
> overwrite succeeds.
>
> It seems that smbd dies after it has created dir/file but before
> reporting this fact to the client. New smbd gets spawned by inetd
> then.

Following my fading memory here, but....

What file system are you sharing?  VFAT by chance?  For some reason
this sounds vaguely like a truncate bug Tridge fixed a few monthds
back.  Try 2.2.2 (released over the weekend).

If you are exporting a VFAT fs, try to reproduce the same behavior
using ext2.







cheers, jerry
 ---------------------------------------------------------------------
 www.samba.org              SAMBA Team              jerry_at_samba.org
 www.plainjoe.org                                jerry_at_plainjoe.org
 --"I never saved anything for the swim back." Ethan Hawk in Gattaca--

