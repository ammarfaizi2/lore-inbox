Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129053AbRBBCvO>; Thu, 1 Feb 2001 21:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbRBBCvE>; Thu, 1 Feb 2001 21:51:04 -0500
Received: from [200.222.195.81] ([200.222.195.81]:7043 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S129053AbRBBCuz>; Thu, 1 Feb 2001 21:50:55 -0500
Date: Fri, 2 Feb 2001 00:50:36 -0200
From: Frédéric L. W. Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: problem with devfsd compilation
Message-ID: <20010202005036.J160@pervalidus.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.14i
X-Mailer: Mutt/1.3.14i - Linux 2.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Georg Nikodym wrote:

> Also, RH7's /etc/rc.sysinit can already start devfsd
> automatically with the following line:   

> [ -e /dev/.devfsd -a -x /sbin/devfsd ] && /sbin/devfsd /dev

If devfs is mounted and devfsd exists, start devfsd.

> So, all you have to do is create an empty file /dev/.devfsd

Not true. I'm pretty sure /dev/.devfsd is only created when you
mount devfs at boot time or via mount -t devfs devfs /dev in
your system initialization script. Creating /dev/.devfsd with
touch defeats the purpose of /etc/rc.sysinit example.

crw-------  1 root     root     144,  0 Dec 31  1969 .devfsd

-- 
Frédéric L. W. Meunier - http://www.pervalidus.net/
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-717-2399 (Niterói-RJ BR)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
