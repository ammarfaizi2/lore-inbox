Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286160AbRLZGUu>; Wed, 26 Dec 2001 01:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286167AbRLZGUl>; Wed, 26 Dec 2001 01:20:41 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:20243 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S286160AbRLZGU0>; Wed, 26 Dec 2001 01:20:26 -0500
Date: Wed, 26 Dec 2001 09:20:24 +0300
From: Oleg Drokin <green@namesys.com>
To: Christian Ohm <chr.ohm@gmx.net>
Cc: Hans Reiser <reiser@namesys.com>, linux-kernel@vger.kernel.org
Subject: Re: file corruption in 2.4.16/17
Message-ID: <20011226092024.A871@namesys.com>
In-Reply-To: <20011222220223.GA537@moongate.thevoid.net> <3C26F2AC.1050809@namesys.com> <20011225004459.GB3752@moongate.thevoid.net> <3C285384.3020302@namesys.com> <20011226005327.GA3970@moongate.thevoid.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011226005327.GA3970@moongate.thevoid.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Dec 26, 2001 at 01:53:27AM +0100, Christian Ohm wrote:
> > So if I understand right, Andre Hedrick thinks it might be whatever 
> > driver is in the 2.4.16 kernel?
> if it is, it seems to be the way reiserfs uses it, and not a general issue
> of the driver itself. i don't really think this is a hardware problem,
> unless anyone can give me a convincing reason why it should/could be.
Well, there were not so much reports like yours on this list recently,
which should mean something.

> > If you can reproduce it for 2.4.17 we will eagerly debug it.
> i'll try, though i'm not really eager to get my files corrupted. so i think
You can make a backup first.

> i'll just copy some files from the old to the new drive and diff them to see
> if they get corrupted with a plain 2.4.17 kernel. if they do, any ideas how
You've just described the way I tracked down memory problems several years ago ;)

> to track it down further?
Perhaps several samples of corrupted files (and their original versions),
also make sure that while this corruption occurs with reserfs on the new drive, it
does not occurs with non-reiserfs filesystem on the new drive.
Also try to copy your files and see if you get random corrupted files or is the corrupted
filelist is the same all the time.
Look into your log for any strange messages. (you might even recompile your
kernel with CONFIG_REISERFS_CHECK enabled to allow for more checks to be made)

Bye,
    Oleg 
