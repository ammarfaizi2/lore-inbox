Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316974AbSGCIls>; Wed, 3 Jul 2002 04:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316976AbSGCIlr>; Wed, 3 Jul 2002 04:41:47 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:46275 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316974AbSGCIlq>; Wed, 3 Jul 2002 04:41:46 -0400
Date: Wed, 3 Jul 2002 10:44:00 +0200
From: Ulrich Wiederhold <U.Wiederhold@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: rtl-8139
Message-ID: <20020703084359.GA507@sky.net>
References: <20020703072335.90799.qmail@web21310.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20020703072335.90799.qmail@web21310.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-Operating-System: Debian GNU/Linux 3.0 (Kernel 2.4.17-rc2)
Organization: Using Linux Only
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
* srinivasa k <kshriny@yahoo.com> [020703 09:23]:
this is a german speaking mailing list.

>    I'm having rtl8139 ethernet card. I just tried the
> option lsmod, it is not showing any module for that
> device. 
lsmod only shows already loaded modules.

> I have complied the source and tried to insert
> the module, but it is showing the device is busy.
?
I suppose you compiled a new kernel, set
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_8139TOO=m     #<--- that's the module you need.

Don't forget "update-modules" and "depmod -va" after making the modules.
And modify your /etc/modutils/aliases file:
alias eth0 8139too
      ^^^^
      that's your interface name, should be eth0 for your first NIC.

Then load the module using "modprobe 8139too". Check the loaded modules
using "lsmod":
[...]
8139too                11936   1

And continue configuring your network. Hint:
man ifconfig
man route

>   Can any one help me in solving out this problem ?
I hope I could.

Try to join an english-speaking mailing list if you don't speak german,
look for it at www.debian.org.

Regards
Uli

-- 
'The box said, 'Requires Windows 95 or better', so i installed Linux - TKK 5
