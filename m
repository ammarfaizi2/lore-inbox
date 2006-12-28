Return-Path: <linux-kernel-owner+w=401wt.eu-S932809AbWL1JpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932809AbWL1JpF (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 04:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932848AbWL1JpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 04:45:05 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:36774 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932809AbWL1JpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 04:45:04 -0500
Date: Thu, 28 Dec 2006 10:43:29 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org, Trond Myklebust <trond.myklebust@fys.uio.no>,
       nfs@lists.sourceforge.net
Subject: Re: VFS: Busy inodes after unmount. Self-destruct in 5 seconds. 
 Have a nice day...
In-Reply-To: <200612281027.09783.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.61.0612281041340.15825@yvahk01.tjqt.qr>
References: <200612281027.09783.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 28 2006 10:27, Jesper Juhl wrote:
>
>I get this message in my webservers (with NFS mounted homedirs) logs once 
>in a while : 
>
>  kernel: VFS: Busy inodes after unmount. Self-destruct in 5 seconds.  Have a nice day...

This happens when the underlying "block device" disappears, the most 
prominent case being ejecting the CD while the fs is still mounted. I 
have not seen it with nfs yet, since networked fs don't have any 
real backing device and instead provide either [waiting for 
reconnection] or -EIO, i.e. proper error handling.

>

	-`J'
-- 
