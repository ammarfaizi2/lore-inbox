Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136106AbREJMZ7>; Thu, 10 May 2001 08:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136122AbREJMZt>; Thu, 10 May 2001 08:25:49 -0400
Received: from dial-142169.HRZ.Uni-Dortmund.DE ([129.217.142.169]:34824 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S136106AbREJMZj> convert rfc822-to-8bit; Thu, 10 May 2001 08:25:39 -0400
Date: Thu, 10 May 2001 13:44:53 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3
Message-ID: <20010510134453.A6816@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <01050910381407.26653@bugs>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <01050910381407.26653@bugs>; from martin@bugs.unl.edu.ar on Wed, May 09, 2001 at 10:38:14 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 May 2001, Martín Marqués wrote:

> There has also been lots of talks about reiserfs being the cause of
> some data lose and performance lose (not sure about this last one).

I never experienced ReiserFS data loss, but I did experience read
performance loss over ext2fs and switched that file system back to ext2.
The ReiserFS people could not reproduce the problem, so I'm not sure
what was the actual cause.

ext3fs has never given me any problems, but I did not have it in
production use where I discovered major ReiserFS <-> kNFSd
incompatibilities. ext3 has a 0.0.x version number which suggests it's
not meant for production use. 

XFS is claimed to work with NFS, but not currently availabe for Linux
2.4.4.

JFS has some showstopper bugs that would prevent me from using it.

If you're deploying a cache partition such as /var/squid (possibly
having log files in another /var/log partition on another disk drive),
what's the point about not running (e.  g.) mke2fs and squid -z on boot,
as well as mounting the system partitions (/usr) read-only (prevents
fsck on next reboot)? mke2fs is faster than reiserfs recovery probably
;-)
