Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751465AbWFPTTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbWFPTTx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 15:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWFPTTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 15:19:53 -0400
Received: from hera.kernel.org ([140.211.167.34]:9405 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751465AbWFPTTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 15:19:51 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: klibc
Date: Fri, 16 Jun 2006 12:19:17 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6v07l$7lv$1@terminus.zytor.com>
References: <20060604135011.decdc7c9.akpm@osdl.org> <bda6d13a0606091613h3334facbrcb86dbb2de01b412@mail.gmail.com> <e6d15e$j4l$1@terminus.zytor.com> <bda6d13a0606152302v6598ce84sf4c7066705c3284f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1150485557 7872 127.0.0.1 (16 Jun 2006 19:19:17 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 16 Jun 2006 19:19:17 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <bda6d13a0606152302v6598ce84sf4c7066705c3284f@mail.gmail.com>
By author:    "Joshua Hudson" <joshudson@gmail.com>
In newsgroup: linux.dev.kernel
>
> I've come to the conclusion that there is no good way to return to the
> initramfs at all
> after init moves to the real root device. What I have found is that the only way
> is for another process to keep a cwd or open file handle on the initramfs which
> plays very badly with killall.
> 
> Anybody got a way to make a user process other than init involunerable
> to kill -9? <g>
> 

Actually, does init close all its file descriptors?  Otherwise you
could simply pass a file descriptor to init when init is executed.

If init explicitly closes file descriptors then that's not possible,
but perhaps that could be fixed in init.

On the other hand, if you killall -9 arbitrary processes as root, then
perhaps getting a dirty filesystem on reboot is ugly but not
catastrophic.

	-hpa

