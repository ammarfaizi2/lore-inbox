Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131711AbRBMPKc>; Tue, 13 Feb 2001 10:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131788AbRBMPKX>; Tue, 13 Feb 2001 10:10:23 -0500
Received: from host217-32-132-155.hg.mdip.bt.net ([217.32.132.155]:64004 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S131711AbRBMPKM>;
	Tue, 13 Feb 2001 10:10:12 -0500
Date: Tue, 13 Feb 2001 15:12:56 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Thomas Foerster <puckwork@madz.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: How to install Alan's patches?
In-Reply-To: <20010213150328Z131694-514+4497@vger.kernel.org>
Message-ID: <Pine.LNX.4.21.0102131510300.829-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan's patches are installed like this:

# cd /usr/src
# tar xIf linux-2.4.1.tar.bz2
# cd linux
# patch -sp1 < ../patch-2.4.1-ac6
# chown -R root:root .

Note the "-sp1" and that you need to be _inside_ the tree. Also, you don't
need to waste another process ("cat") and create a pipe, just use shell
input redirection facility "<".

Regards,
Tigran

On Tue, 13 Feb 2001, Thomas Foerster wrote:

> Hi folks,
> 
> sorry for the silly question, but i can't get it to work :
> 
> I have linux-2.4.1 unpacked, configured and installed.
> Now i want to apply Alan Cox patche (linux-2.4.1-ac9), but i always get
> these errors :
> 
> [root@space src]# cat /home/puck/patch-2.4.1-ac9 | patch -p0
> can't find file to patch at input line 4
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> --------------------------
> |diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/CREDITS linux.ac/CREDITS
> |--- linux.vanilla/CREDITS      Wed Jan 31 22:05:29 2001
> |+++ linux.ac/CREDITS   Fri Feb  9 13:19:13 2001
> --------------------------
> File to patch: 
> [root@space src]#
> 
> Do i have to create linux.vanilla and linux.ac, or what's the magic?! :-)
> 
> Thanx a lot,
>   Thomas
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

