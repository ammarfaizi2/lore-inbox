Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUBQI0b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 03:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbUBQI0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 03:26:31 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:25861 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S263584AbUBQI0a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 03:26:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Tom Guilliams <tguilliams@san.rr.com>, DHollenbeck <dick@softplc.com>
Subject: Re: [BusyBox] [Fwd: Loopback device setup?]
Date: Tue, 17 Feb 2004 10:22:38 +0200
X-Mailer: KMail [version 1.4]
Cc: busybox@mail.codepoet.org, linux-kernel@vger.kernel.org
References: <40314A9F.3090801@softplc.com> <40315E31.90201@san.rr.com>
In-Reply-To: <40315E31.90201@san.rr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402171022.38290.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 February 2004 02:20, Tom Guilliams wrote:
> in /driver/block/loop.c -
>
> loop_set_fd()
>
> 		/*
>                   * If we can't read - sorry. If we only can't write -
>                  		 * well, it's going to be read-only.
>                   */
>                  if (!aops->readpage)
>                          goto out_putf;
>
> I confirmed the "if (!aops->readpage)" is true.  I'm not sure what the
> readpage routine is trying to do (which dev or file) in my command below -
> # mount -t ext2 -o loop ramdisk.image rootfs
>
> Anyone have any thoughts??  This is all being done in the /tmp
> dircectory which is mounted as "tmpfs".  Not sure if that has anything
> to do with it.

I recall that tmpfs cannot do readpage (by design?).
CCing LKML, maybe someone will pour in more info.
-- 
vda
