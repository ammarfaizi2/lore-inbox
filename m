Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVA0XRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVA0XRc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 18:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVA0XP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 18:15:27 -0500
Received: from spc2-brig1-3-0-cust232.asfd.broadband.ntl.com ([82.1.142.232]:28386
	"EHLO ppgpenguin.kenmoffat.uklinux.net") by vger.kernel.org with ESMTP
	id S261290AbVA0XJu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 18:09:50 -0500
Date: Thu, 27 Jan 2005 21:10:49 +0000 (GMT)
From: Ken Moffat <ken@kenmoffat.uklinux.net>
To: Viktor Horvath <ViktorHorvath@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patches to 2.6.9 and 2.6.10 - make menuconfig shows "v2.6.8.1"
In-Reply-To: <1106851254.720.4.camel@Charon>
Message-ID: <Pine.LNX.4.58.0501272101500.6725@ppg_penguin.kenmoffat.uklinux.net>
References: <1106851254.720.4.camel@Charon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2005, Viktor Horvath wrote:

> Hello everybody,
>
> today I patched myself up from 2.6.7 vanilla to 2.6.10 vanilla, but
> after all patches succeeded, "make menuconfig" shows "v2.6.8.1
> Configuration". Even worse, a compiled kernel calls in his bootlog
> himself "2.6.8.1". When installing the whole kernel package, this
> behaviour doesn't show up.
>

 Looks like you went 2.6.7, 2.6.8, 2.6.8.1 - you didn't *need* 2.6.8.1,
2.6.9 is against 2.6.8 not 2.6.8.1.  So, when you applied 2.6.9 you got
rejections (at a minimum, the top level Makefile, but the other stuff
from 2.6.8.1 should have rejected because it had already been applied).
>From there onwards, the top level Makefile still contains the 2.6.8.1
version info and doesn't match what the next patch is looking to change.

 Whenever you apply patches, you need to make sure there are no errors!
e.g. use 'find' to look for '*.rej' files.

Ken
-- 
 das eine Mal als Tragödie, das andere Mal als Farce

