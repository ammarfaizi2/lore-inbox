Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265354AbTL0K5H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 05:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbTL0K5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 05:57:07 -0500
Received: from [213.94.4.22] ([213.94.4.22]:35969 "EHLO sacarino.pirispons.net")
	by vger.kernel.org with ESMTP id S265354AbTL0K5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 05:57:03 -0500
Date: Sat, 27 Dec 2003 11:57:00 +0100
From: Kiko Piris <kernel@pirispons.net>
To: linux-kernel@vger.kernel.org
Subject: A couple of questions about laptop-mode for 2.6, version 4
Message-ID: <20031227105700.GA3554@sacarino.pirispons.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3FE92517.1000306@samwel.tk> <20031224111640.GL1601@suse.de> <3FE9AFFC.2080302@samwel.tk> <20031225100648.GB13382@conectiva.com.br> <3FEAFE66.2020602@samwel.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FEAFE66.2020602@samwel.tk>
User-Agent: Mutt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/12/2003 at 16:12, Bart Samwel wrote:

> Thanks, I've fixed this. Here is the resulting patch.
> 
> I've got another problem getting this stuff to work. The problem lies 
> with my HD: it just doesn't respect the spindown time, I've got it set 
> to hdparm -S 4 and it just doesn't spin down, even though there's no 
> activity whatsoever! hdparm -B 254 gives me:

Hi,

since laptop-mode was a feature from 2.4 wich I was missing in 2.6, I've
decided to give it a try.

However, I have not a clue about kernel programming (and neither about
filesystems implementations), so looking at the source code is useless
to me (as I do not understand anything :-[). So, please forgive-me if
I'm asking obvious questions:

1.- I've used the patch posted in the message I'm replying (From: Bart
Samwel, Date: Thu, 25 Dec 2003 16:12:38 +0100). Hope this is the correct
one.

2.- I plan to use cpudyn (http://mnm.uib.es/~gallir/cpudyn) to spin down
the disks (as I did in 2.4). If I have understood it correctly, that
functionality is what the smart_spindown script does. I guess there will
be no problems with that.

3.- As I use mainly ext3 partitions, I read in the first post regarding
laptop-mode with ext3, that I had to mount my filesystems with
commit=$MAX_AGE (beeing that $MAX_AGE, the value used in
linux-2.4/Documentation/laptop-mode.sh). Is this correct?

If the previous answer is yes, what do you think would be the best way
to do so? I don't like modifying /etc/fstab, because if I boot another
(non laptop-mode) kernel (or I want to disable laptop-mode when doing
something important); I guess nasty things could happen if I forget to
remount my ext3 filesystems appropiately.

I was thinking in modifying laptop-mode.sh to read /proc/mounts and
remount ext3 partitions with the appropiate parameter (on start and also
on stop). But I quite don't like this method, it seems "ugly" to me (and
does not solve the problem of mounting filesystems after
activating/deactivating laptop-mode).

Do you have a better idea? I know this last question is a userspace
problem, but AFAICS it's tightly related to the way laptop-mode is
implemented in the kernel (always suposing the answer to 3.- is yes).

Thanks in advance!

-- 
Kiko
