Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVCEJHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVCEJHD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 04:07:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVCEJHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 04:07:03 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:6844 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261517AbVCEJGi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 04:06:38 -0500
Date: Sat, 5 Mar 2005 10:06:37 +0100
From: Florian Engelhardt <flo@dotbox.org>
To: linux-kernel@vger.kernel.org
Cc: Brad Campbell <brad@wasp.net.au>
Subject: Re: freezes with reiser4 in a raid1 with 2.6.11-rc5-mm1
Message-ID: <20050305100637.3aa6e1b8@discovery.hal.lan>
In-Reply-To: <422597C3.5020207@wasp.net.au>
References: <1109758204.422590fca7872@domainfactory-webmail.de>
	<422597C3.5020207@wasp.net.au>
X-Mailer: Sylpheed-Claws 1.0.1cvs11.1 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, 02 Mar 2005 14:38:59 +0400
Brad Campbell <brad@wasp.net.au> wrote:

> Florian Engelhardt wrote:
> > 
> > I activated the raid (/dev/md0), then mounted it, and after
> > that i was starting nfs. I was able to mount the share
> > on my desktop, creating direcrotys was no problem, but
> > as soon as i was copying a file to the share, the server
> > freezed.
> > Creating files localy (while loged in via ssh) is leading
> > to the process is staying in state D.
> > Sometimes, when i start nfsd, the system reboots immediately,
> > sometimes not.
> > At the momment, most of the processes are in state D, reboot
> > does not work, and i am not at home, so i am unable to reboot
> > the machine manualy.
> 
> Neat trick which I only discovered in desparation last week when
> battling a RAID lockup on the -rc4-mm1 kernel on a remote box.
> 
> I was also having hard lockup issues, but reseating all my PCI cards
> appear to have rectified that one.

Well, there are not much PCI-Cards in this server and reseating them
didnt fix it.

> As root. echo b > /proc/sysrq-trigger
> 
> Of course only if you have alt-sysrq built in.

Thanks for that, i was able to reboot the machine with that trick, but
i couldnt find anything bad in the messages file.

I made some further tests with the server:
Deactivating the raid, and formating the hd´s (hdc and hdd) with
reiser4, mounting them and sharing them via nfs and ftp worked great, no
freezes, no reboots, everything perfect, even the performance.
But as soon, as i activated the raid, the server freezed, or rebooted.

Maybe this problem is not a bug in a single component (eg: nfs or
reiser4), i think it is the combination of linux raid with reiser4, but
i dont know.
I will try to get the raid up and running with ext3 and/or jfs.

Then we know exactly, if it is the combination of raid and reiser4.

Kind regards

Florian Engelhardt

-- 
"I may have invented it, but Bill made it famous"
David Bradley, who invented the (in)famous ctrl-alt-del key combination
