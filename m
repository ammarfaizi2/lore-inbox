Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbVK0GHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbVK0GHm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 01:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbVK0GHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 01:07:42 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:46092 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750880AbVK0GHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 01:07:41 -0500
Date: Sun, 27 Nov 2005 07:07:34 +0100
From: Willy Tarreau <willy@w.ods.org>
To: David Brown <dmlb2000@gmail.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: linux-2.6.14.tar.bz2 permissions
Message-ID: <20051127060734.GM11266@alpha.home.local>
References: <9c21eeae0511261352u33e32343wf50062ba3038ef06@mail.gmail.com> <200511262346.27907.s0348365@sms.ed.ac.uk> <9c21eeae0511261713vacf13f5u5fdf19711635a381@mail.gmail.com> <200511270138.25769.s0348365@sms.ed.ac.uk> <29495f1d0511261746y12a0c356ueb3d5bb08aa6f6a@mail.gmail.com> <9c21eeae0511261751p6741ad4fgd3f3d762e4c377f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c21eeae0511261751p6741ad4fgd3f3d762e4c377f6@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2005 at 05:51:34PM -0800, David Brown wrote:
> > Maybe you are untarring as non-root and David is untarring as root?
> 
> Yeah you can't very well compile and install a kernel without
> permissions to /boot ;)

I disagree with you David. It's been years since I last compiled a
kernel as root, and even longer without untarring it as root ! I have
/usr/src chmod g+w for group "linux" to which I belong. I untar new
kernels there, compile them, etc... as my own user. Then I only do:
  $ sudo make modules_install
  $ sudo cp arch/i386/boot/bzImage System.map .config /boot/<version>
  $ sudo vi /etc/lilo.conf
  $ sudo lilo

And it brings me real advantages : during all the compilation phase,
I can use everything I have in *my* environment, aliases, functions,
scripts, tools, etc... that I would not necessarily have as root.

Believe me, for no reason I would switch back to the old age when
I did all this as root !

Regards,
Willy

