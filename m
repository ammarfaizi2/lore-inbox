Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRBQHW2>; Sat, 17 Feb 2001 02:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129608AbRBQHWI>; Sat, 17 Feb 2001 02:22:08 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:9743 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129387AbRBQHWF>;
	Sat, 17 Feb 2001 02:22:05 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Shawn Starr <Shawn.Starr@sh0n.net>
cc: lkm <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM]: grep hanging with ReiserFS 
In-Reply-To: Your message of "Sat, 17 Feb 2001 02:12:40 CDT."
             <3A8E2467.FC6FE1B4@sh0n.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 17 Feb 2001 18:21:58 +1100
Message-ID: <15264.982394518@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Feb 2001 02:12:40 -0500, 
Shawn Starr <Shawn.Starr@sh0n.net> wrote:
> grep -r "216.234.235.46" *
>Im using grep in /etc and its just waiting....

grep -r follows symlinks and tries to open named pipes.  If you have
qmail installed then /etc/qmail is a symlink to /var/qmail and named
pipe /var/qmail/queue/lock/trigger lives down there.  grep hangs trying
to open the pipe.  Not a reiserfs problem, just a badly designed
application.

