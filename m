Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTJRQ17 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 12:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbTJRQ17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 12:27:59 -0400
Received: from 12-229-144-126.client.attbi.com ([12.229.144.126]:31104 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S261684AbTJRQ16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 12:27:58 -0400
Message-ID: <3F916A0C.10800@comcast.net>
Date: Sat, 18 Oct 2003 09:27:56 -0700
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031008
X-Accept-Language: en-us
MIME-Version: 1.0
To: arekm@pld-linux.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: initrd and 2.6.0-test8
X-Enigmail-Version: 0.76.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hi,
> 
> Seems that something changed between test7 and test8 regarding initrd or romfs 
> support. I'm using highly modularized 2.6.0 kernel which has all filesystems 
> beside romfs compiled as modules (romfs is compiled inside of kernel).
> 
> Modules for my rootfs are loaded from initrd (which is image with romfs as 
> filesystem) but starting from test8 kernel is not able to mount initrd 
> filesystem - stops with typical message about not being able to mount rootfs.
> 
> cset test7 from 20031012_0407 is known to be ok so something was changed later


I noticed this happened in 2.6.0-test6-mm4. Backing out this patch fixes
it in the short-term.

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm4/broken-out/RD0-initrd-B6.patch


-Walt


