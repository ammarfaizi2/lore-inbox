Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286239AbRL0K7V>; Thu, 27 Dec 2001 05:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286241AbRL0K7L>; Thu, 27 Dec 2001 05:59:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:41708 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S286239AbRL0K7A>;
	Thu, 27 Dec 2001 05:59:00 -0500
Message-ID: <3C2AFEED.9020700@gmx.at>
Date: Thu, 27 Dec 2001 11:58:53 +0100
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:0.9.5) Gecko/20011023
X-Accept-Language: de-at, de, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Booting a modular kernel through a multiple streams file
In-Reply-To: <200112232305.fBNN5vM19844@ns.caldera.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Meissner wrote:

 > In article <E16I8zQ-0000d9-00@the-village.bc.nu> you wrote:
 >
 >>>Basically what Grub does is loads the kernel modules from disk
 >>>into memory, and 'tells' the kernel the memory location to load
 >>>them from, very similar to how an initrd file is loaded. The problem
 >>>is Linux, is not MBS compilant and doesn't know to look for and load
 >>>the modules.
 >>>
 >
 >>And vendors who've shipped GRUB still have to ship Lilo because Grub 
plain
 >>doesn't work on some machines. Lilo has the virtue that its extremely 
simple
 >>in what it does and how it does it. It works in a suprisingly large 
number
 >>of cases and can handle interesting setups that GRUB really struggles 
with.
 >>
 >
 > Apart that it moves the initrd somewhere unsafe on high memory machines
 > and some other odds ends we have fixed, I know of exactly 1 problem 
with a
 > hw raid controller, which we did not come around to debug yet.


I'm just wondering if you mean the (almost) RAID HPT370. You can fix
this by avoiding the "embed" command, which overwrites the raid setup
information. Just "dd" the file system module to a higher offset (e.g.
16) and run grub's "install" command manually.

Wilfried


-- 
Terorists crashed an airplane into the server room, have to remove
/bin/laden. (rm -rf /bin/laden)


