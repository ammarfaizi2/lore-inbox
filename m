Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289104AbSAPVzJ>; Wed, 16 Jan 2002 16:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289038AbSAPVy7>; Wed, 16 Jan 2002 16:54:59 -0500
Received: from mailhost.teleline.es ([195.235.113.141]:6460 "EHLO
	tsmtp7.mail.isp") by vger.kernel.org with ESMTP id <S289156AbSAPVyp>;
	Wed, 16 Jan 2002 16:54:45 -0500
Date: Wed, 16 Jan 2002 22:58:45 +0100
From: Diego Calleja <grundig@teleline.es>
To: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Rik spreading bullshit about VM
Reply-To: grundig@teleline.es
In-Reply-To: <20020116200459.E835@athlon.random>
In-Reply-To: <20020116200459.E835@athlon.random>
X-Mailer: Spruce 0.7.4 for X11 w/smtpio 0.8.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20020116215449Z289156-13996+7212@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Andrea Arcangeli wrote:
> attached) and most important I don't have a single bugreport about the
> current 2.4.18pre2aa2 VM (except perhaps the bdflush wakeup that seems
> to be a little too late and that deals to lower numbers with slow write
> load etc.., fixable with bdflush tuning). Mainline VM kills too easily,

Well, I haven't reported it yet, but booting my box with mem=4M
gave as result: (running 2.4.18-pre2aa2):
diego# cat /var/log/messages | grep gfp
Jan 13 15:37:10 localhost kernel: __alloc_pages: 0-order allocation failed
(gfp=0xf0/0)
Jan 15 16:06:28 localhost kernel: __alloc_pages: 0-order allocation failed
(gfp=0xf0/0)
Jan 15 18:37:21 localhost kernel: __alloc_pages: 0-order allocation failed
(gfp=0xf0/0)
Jan 15 21:58:32 localhost kernel: __alloc_pages: 0-order allocation failed
(gfp=0xf0/0)
Jan 15 21:58:33 localhost kernel: __alloc_pages: 0-order allocation failed
(gfp=0xf0/0)
diego# 

Each script of /etc/rc.d was killed by VM when it was started, there wasn't
any "OOM", just
"VM killed..." or something similar.
As /etc/rc.d scripts were killed, I couldn't start swap.

The gfp=0x... numbers were not always the same, but I can't remember them
because syslogd wasn't running.
I can repeat this if you want and I'll copy all messages.

..I remember running 2.2.14 in a 386 box with 4MB of RAM and 8 or 16 of
swap. It was veeery slow, but even I could run apache :-)...



> this is fixed in -aa VM and -aa VM has a number of other issues
> resolved, but mainline 2.4 vm isn't that far either. In the last few
> days I was playing with pte-highmem, soon I will spend some time merging
> -aa VM into mainline with Marcelo if he likes to.
> 
> Andrea
> 
> PS. I know the interviewer and he's usually very accurate, so I don't
> think this could be a misunderstanding where you say one thing and they
> writer another one just to create troubles.
> 
> 
