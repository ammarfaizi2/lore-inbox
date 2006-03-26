Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWCZSwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWCZSwy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 13:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWCZSwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 13:52:54 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:31957 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S932109AbWCZSwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 13:52:53 -0500
Message-ID: <4426E303.9000701@vc.cvut.cz>
Date: Sun, 26 Mar 2006 20:52:51 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20060205 Debian/1.7.12-1.1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: mikado4vn@gmail.com
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Glynn Clements <glynn@gclements.plus.com>, linux-kernel@vger.kernel.org,
       linux-c-programming@vger.kernel.org
Subject: Re: Virtual Serial Port
References: <442582B8.8040403@gmail.com> <Pine.LNX.4.61.0603251945100.29793@yvahk01.tjqt.qr> <4425FB22.7040405@gmail.com> <Pine.LNX.4.61.0603261127580.22145@yvahk01.tjqt.qr> <4426CADF.2050902@gmail.com>
In-Reply-To: <4426CADF.2050902@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikado wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
>>  guest writes to /dev/ttyS0
>>  vmware connects its virtual S0 to the host's ttyFakeS0
>>  minicom on the host to ttyFakeS0
>>or even
>>  vmware S0 to host's ttyS0
>>  other remote machine do minicom to ttyS0
>>
>>The reason for FakeS0 is that vmware does not know about ptys, 
>>unfortunately.
> 
> 
> Yes, VMWare doesn't support serial port using host's ttys any more. My
> idea is:
> 
> [host - application] <- read/write -> [virtual serial port
> /dev/ttyFakeS0] <- read/write over virtual null-modem serial cable ->
> [host - real serial port /dev/ttyS0] <- read/write -> [VMWare - application]

Although it is quite irrelevant to LKML (you may want to visit 
www.vmware.com/community/index.jspa and ask there...), you can connect guest's 
serial port also to Unix socket - and in such situation you need virtual serial 
port driver only if 'host - application' does not know how to use /dev/tty* (for 
unix socket <-> /dev/ptyp* app look at 
http://platan.vc.cvut.cz/ftp/pub/vmware/serpipe.tar.gz).
								Petr

