Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290930AbSASK5o>; Sat, 19 Jan 2002 05:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290931AbSASK5c>; Sat, 19 Jan 2002 05:57:32 -0500
Received: from AMontpellier-201-1-6-45.abo.wanadoo.fr ([80.13.220.45]:5380
	"EHLO awak") by vger.kernel.org with ESMTP id <S290930AbSASK53>;
	Sat, 19 Jan 2002 05:57:29 -0500
Subject: Re: rm-ing files with open file descriptors
From: Xavier Bestel <xav@awak.dyndns.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <a2almg$vtl$1@cesium.transmeta.com>
In-Reply-To: <87lmevjrep.fsf@localhost.localdomain>
	<Pine.LNX.3.95.1020118163838.3008B-100000@chaos.analogic.com>
	<a2afsg$73g$2@ncc1701.cistron.net>  <a2almg$vtl$1@cesium.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 19 Jan 2002 11:57:22 +0100
Message-Id: <1011437843.25028.6.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-01-19 at 03:29, H. Peter Anvin wrote:
> Followup to:  <a2afsg$73g$2@ncc1701.cistron.net>
> By author:    Miquel van Smoorenburg <miquels@cistron.nl>
> In newsgroup: linux.dev.kernel
> > 
> > Well no. new_fd will refer to a completely new, empty file
> > which has no relation to the old file at all.
> > 
> > There is no way to recreate a file with a nlink count of 0,
> > well that is until someone adds flink(fd, newpath) to the kernel.
> > 
> 
> This *might* work:
> 
> link("/proc/self/fd/40", newpath);
> 

Mmh, in this case /proc/self/fd/40 would be a symlink to nothing ...

	

