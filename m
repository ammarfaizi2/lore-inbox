Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264376AbTDKPNR (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 11:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbTDKPNR (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 11:13:17 -0400
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:11500 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S264376AbTDKPNQ (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 11:13:16 -0400
Date: Fri, 11 Apr 2003 17:34:59 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel hcking
Message-ID: <20030411153459.GD25862@wind.cocodriloo.com>
References: <20030411170709.A33459@freebsdcluster.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030411170709.A33459@freebsdcluster.dk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 05:07:09PM +0200, Vikram Rangnekar wrote:
> 
> I'm a kernel newbie and just wanted to know what do most kernel hackers do
> when working on the kernel say 2.5 when you make changes do u need to
> recompile the kernel and reboot the machine to test your small modification
> or do people use something like bochs. Also every time you makes changes in
> the kernel it must be hell to recompile the whole thing do kernel hackers
> just compile the specific file and link it into the kernel or something. Some
> of these will be stupid questions to most of you but I am curious since I've
> been working on the kernel lately and recompiling and rebooting is driving me
> nuts

I'm also newbie at actually coding on the kernel, and I've
been using user-mode-linux to try my patches... it's easy and clean,
just make a very small config so that the initial compile is
also fast.

Then, when you are doing incremental compiling, just do a
"make -j linux", this is very fast when you are not recompiling
all .o files since the makefile checks the last-modified date
for the .c files.

For maximum performance, also use ccache with (very important) the
cache directory on the same filesystem than the compile directory.
I keep a "compile" directory and a "ccache" directory at the same
level.

When testing with user-mode-linux, you can simply type
./linux and the new kernel boots in your terminal. If
you want to boot a real machine, I suggest you get a
second computer and boot it by loading the kernel off
the net, using tftp protocol.

Ping me if you want some more help at this last issue.

Greets and have fun!

Antonio.


