Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316970AbSFFN3X>; Thu, 6 Jun 2002 09:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316968AbSFFN3W>; Thu, 6 Jun 2002 09:29:22 -0400
Received: from pD9E23FC2.dip.t-dialin.net ([217.226.63.194]:28033 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316964AbSFFN3U>; Thu, 6 Jun 2002 09:29:20 -0400
Date: Thu, 6 Jun 2002 07:29:10 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Michael Zhu <mylinuxk@yahoo.ca>
cc: markh@compro.net, <kernelnewbies@nl.linux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Load kernel module automatically
Message-ID: <Pine.LNX.4.44.0206060727150.3833-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 5 Jun 2002, Michael Zhu wrote:
> Hi, I've read the man page of modules.conf. But I
> still couldn't figure out how to solve my problem. I
> mean how to change the modules.conf file. Can I edit
> this file directly? Can anyone give me an example?
> 
> Thanks.

/etc/modules.conf is quite useful if you work with /dev files w/0 devfs, 
protocol families etc.

Example: you have your sound driver compiled as a module. In /dev you have 
a couple of sound character devs with major number 14. Now you write an 
alias for it into your /etc/modules.conf:

alias	char-major-14	soundcore

Example: you have your ipv6 over ipv4 compiled as a module. Your protocol 
family 41 requires ipv6 to be loaded. Therefore say:

alias	net-pf-41	ipv6

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

