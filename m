Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSFJOzA>; Mon, 10 Jun 2002 10:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSFJOy7>; Mon, 10 Jun 2002 10:54:59 -0400
Received: from firewall.ill.fr ([193.49.43.1]:3211 "HELO out.esrf.fr")
	by vger.kernel.org with SMTP id <S315439AbSFJOy6>;
	Mon, 10 Jun 2002 10:54:58 -0400
Date: Mon, 10 Jun 2002 16:54:32 +0200
From: Samuel Maftoul <maftoul@esrf.fr>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: /usr/bin/df reports false size on big NFS shares
Message-ID: <20020610165432.A15246@pcmaftoul.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On several machines, with kernel 2.4.18 the same mounts reports different
sizes than with 2.4.4 :

-------------------------------------------------------------------------
maftoul@brick20:~ > uname  -a 
Linux brick20 2.4.4-4GB #6 Thu Jul 26 10:00:30 CEST 2001 i686 unknown

maftoul@brick20:~ > df -h 
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda1              13G  3.1G  9.5G  25% /
shmfs                 517M     0  516M   0% /dev/shm
grey:/disk91          230G  127G  102G  56% /mntdirect/_disk91
yellow:/disk23        140G  100G   39G  72% /mntdirect/_disk23
violet:/data/id19/external
                      2.7T  1.1T  1.6T  38% /mntdirect/_data_id19_external
maftoul@brick20:~ >
-------------------------------------------------------------------------

maftoul@brick4:~ > uname  -a 
Linux brick4 2.4.18 #3 Thu Apr 4 17:04:20 CEST 2002 i686 unknown
maftoul@brick4:~ > 

maftoul@brick4:~ > df -h 
Filesystem            Size  Used Avail Use% Mounted on
/dev/sda1             4.7G  2.7G  2.0G  58% /
shmfs                 125M     0  124M   0% /dev/shm
grey:/disk91          230G  127G  102G  56% /mntdirect/_disk91
yellow:/disk23        140G  100G   39G  72% /mntdirect/_disk23
violet:/data/id19/external
                      669G -7.0Z  1.6T 101% /mntdirect/_data_id19_external
-------------------------------------------------------------------------

See the violet one ?
The reported size is the same on every 2.4.18 machine using this mount I
saw.

I have to say that these mounts are mounted via the automounter.

Bug ? or what ? 

It's all suse 7.2 , first one (2.4.4) is suse 7.2 base kernel, 2.4.18 is
our own (for firewire better firewire support).


If I send this mail to the wrong place ( which I doubt ) please, say it
so I'll try to report somewhere else.

Thanks 
        Samuel 
