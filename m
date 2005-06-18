Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVFRQse@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVFRQse (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 12:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbVFRQse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 12:48:34 -0400
Received: from ns1.heckrath.net ([213.239.205.18]:53390 "EHLO
	mail.heckrath.net") by vger.kernel.org with ESMTP id S262152AbVFRQsd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 12:48:33 -0400
Date: Sat, 18 Jun 2005 18:51:50 +0200
From: Sebastian Kaergel <mailing@wodkahexe.de>
To: Alessandro <alezzandro@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "mtrr: type mismatch for e0000000,8000000 old: write-back new:
 write-combining" on Kernel 2.6.12
Message-Id: <20050618185150.03d0fe4a.mailing@wodkahexe.de>
In-Reply-To: <42B44919.7070300@gmail.com>
References: <42B44919.7070300@gmail.com>
X-Mailer: Sylpheed version 2.0.0beta2 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2005 18:17:29 +0200
Alessandro <alezzandro@gmail.com> wrote:

> vesafb: framebuffer at 0xe0000000, mapped to 0xe0880000, using 4608k, 
> total 131072k
> vesafb: mode is 1024x768x24, linelength=3072, pages=55
> vesafb: protected mode interface info at c000:56cb
> vesafb: scrolling: redraw
> vesafb: Truecolor: size=0:8:8:8, shift=0:16:8:0
> mtrr: type mismatch for e0000000,8000000 old: write-back new: 
> write-combining

Got some similar problem (?) some time ago, but maybe it's something
completely different.
I fixed it by booting with "video=vesafb:nomtrr", since vesafb's MTRR
usage seems to be broken. See:
http://www.ussg.iu.edu/hypermail/linux/kernel/0408.0/1843.html
