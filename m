Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267037AbUBRXGy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267182AbUBRXGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:06:54 -0500
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:25219
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S267037AbUBRXG2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:06:28 -0500
Subject: Re: 2.6.3 NFS kernel warning
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nick Warne <nick@ukfsn.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4033CE2C.19615.76C399@localhost>
References: <4033CE2C.19615.76C399@localhost>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1077145576.3021.11.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 18 Feb 2004 15:06:16 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På on , 18/02/2004 klokka 12:42, skreiv Nick Warne:
> Hello all,
> 
> I am not registered with the list, so please CC if possible - thanks.
> 
> I am not sure if this is a problem to report (as opposed to my old 
> system's problem), but I get this now in dmesg after building 2.6.3 
> tonight:
> 
> nfs_read_super: get root inode failed
> 
> This is 2.6.3 mounting a NFS from an old 486 box running Linux 2.2.13 
> - and the NFS processes of the same age.
> 
> The mount still works OK though; logs from the 486 report no 
> warnings/errors apart from the version 3 is unknown.
> 
> But I am intrigued why it gives this warning (and the inode.c code 
> seems to imply it is a fatal error, AFAIK) if it still works?

"mount" is probably telling the kernel that it is mounting an NFSv3
partition. When that happens, the kernel retries using NFSv2...

Cheers,
  Trond
