Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261351AbTCaBl5>; Sun, 30 Mar 2003 20:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261352AbTCaBl5>; Sun, 30 Mar 2003 20:41:57 -0500
Received: from zok.SGI.COM ([204.94.215.101]:51865 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S261351AbTCaBl4>;
	Sun, 30 Mar 2003 20:41:56 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre6 modules can't access kernel symbols - build system problem? 
In-reply-to: Your message of "Mon, 31 Mar 2003 05:29:18 +0800."
             <200303310529.18782.mflt1@micrologica.com.hk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 31 Mar 2003 11:53:04 +1000
Message-ID: <26914.1049075584@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003 05:29:18 +0800, 
Michael Frank <mflt1@micrologica.com.hk> wrote:
>I encounter a problem which baffles me, having built same release before
>1) Checked 21-pre6 out from local BK tree
>2) Patched with latest acpi and win4lin
>3) make oldconfig
>4) Made some config changes
>5) make dep, bzImage, modules - use gcc295
>depmod reports missing symbols in all modules

Broken kernel build.  You must make mrproper after applying patches
that change dependencies when using CONFIG_MODVERSIONS=y.

