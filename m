Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290965AbSAaGKB>; Thu, 31 Jan 2002 01:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290968AbSAaGJv>; Thu, 31 Jan 2002 01:09:51 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:47625 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S290965AbSAaGJg>; Thu, 31 Jan 2002 01:09:36 -0500
Date: Thu, 31 Jan 2002 09:09:32 +0300
From: Oleg Drokin <green@namesys.com>
To: Dave Jones <davej@suse.de>, Sebastian Dr?ge <sebastian.droege@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <20020131090932.B4574@namesys.com>
In-Reply-To: <20020130151420.40e81aef.sebastian.droege@gmx.de> <20020130173715.B2179@namesys.com> <20020130163951.13daca94.sebastian.droege@gmx.de> <20020130190905.A820@namesys.com> <20020130174011.L24012@suse.de> <20020130201054.6e150f78.sebastian.droege@gmx.de> <20020130201757.Q24012@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130201757.Q24012@suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jan 30, 2002 at 08:17:57PM +0100, Dave Jones wrote:
> On Wed, Jan 30, 2002 at 08:10:54PM +0100, Sebastian Dr?ge wrote:
>  > I have 3 partitions. Two reiserfs partitions, one mounted on /, one on /home
>  Ok, my test box for reiserfs uses ext3 root, and reiser on a scratch disk.
>  It could be Oleg's earlier guess that it may be reiser-on-root related.
No. I can reproduce with ext2 root & reiserfs mounted separately.
depmod -a -b /mnt causes a crash for me 100% of time.
(of course you need correct /lib/modules/... for that)

>  > It happens with the IDE layer version as in the dj tree and with
>  > acb-io-2.5.3-p2.01212002 update (why haven't you included this in your tree,
>  > Dave?)
>  I never saw Andre pushing it on Linux-kernel (which is unusual for Andre 8)
I dug the original message,
it's subject is "DO NOT USE IT (Re: linux-2.5.3-pre1 and IDE Driver Trouble) FATAL"
msgid is <Pine.LNX.4.10.10201161259270.29434-100000@master.linux-ide.org>
It warns about 2.5.3-pre1 and 2.5.2 is unstable with IDE because there are
conflicts between BIO & ACB. He promised to come up with the fix later.
After that there were no messages from him with patches.
At least not in the lkml.

Bye,
    Oleg
