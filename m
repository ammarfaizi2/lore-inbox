Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267629AbTAHA03>; Tue, 7 Jan 2003 19:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267630AbTAHA03>; Tue, 7 Jan 2003 19:26:29 -0500
Received: from services.cam.org ([198.73.180.252]:29784 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S267629AbTAHA02> convert rfc822-to-8bit;
	Tue, 7 Jan 2003 19:26:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: unknown symbols 2.5.54bk (soundcore/errno nfsd/hash_mem)
Date: Tue, 7 Jan 2003 19:35:06 -0500
User-Agent: KMail/1.4.3
References: <200301070753.34476.tomlins@cam.org>
In-Reply-To: <200301070753.34476.tomlins@cam.org>
Cc: varenet@parisc-linux.org
MIME-Version: 1.0
Message-Id: <200301071935.06849.tomlins@cam.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 7, 2003 07:53 am, Ed Tomlinson wrote:
> Got this doing modules_install this morning:
>
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.54; fi
> WARNING: /lib/modules/2.5.54/kernel/sound/soundcore.ko needs unknown symbol
> errno WARNING: /lib/modules/2.5.54/kernel/fs/nfsd/nfsd.ko needs unknown
> symbol hash_mem
>
> Suspect Neil Brown will fix hash_mem once his patch gets past the Linus
> filter.  I have not seen the second reported.  I do not have ALSA
> selecterd, just OSS.

reversing this cset (what is the command to get the invarient cset name?)

ChangeSet@1.879.1.43, 2003-01-05 20:55:52-08:00, varenet@parisc-linux.org
  [PATCH] linux-2.5.46: Remove unused static variable

    I was doing some cleaning in the parisc files, and took a look at some
    arch indep ones btw.

    This fixes a warning

Seems to fix the problem with soundcore.ko

Ed Tomlinson
