Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262951AbVCQBoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbVCQBoj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 20:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262959AbVCQBoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 20:44:38 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:3324 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262951AbVCQBoW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 20:44:22 -0500
Message-ID: <4238E0EA.8040101@mvista.com>
Date: Wed, 16 Mar 2005 17:44:10 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
CC: linux-kernel@vger.kernel.org,
       Linux and Kernel Video <video4linux-list@redhat.com>
Subject: Re: tvtime audio vs pcHDTV-3000 card and pvHDTV-1.6 software
References: <200503162015.37331.gene.heskett@verizon.net>
In-Reply-To: <200503162015.37331.gene.heskett@verizon.net>
Content-Type: multipart/mixed;
 boundary="------------020606040400080502020304"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------020606040400080502020304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Heavens, no need to clean the tree at all.  Just add "-X <file> to your diff.  I 
have attached what I use for <file>.  It is likely over kill, but should do...

-g

Gene Heskett wrote:
> Greetings;
> 
> I've spent a goodly part of the last 3 hours rebooting, to find out 
> where this audio control function died, and I think now I can point 
> an accusatory finger at the 2.6.11.2 patch with some degree of 
> certainty.
> 
> The scenario goes like this:
> 
> reboot to 2.6.11-rc5, everything works flawlessly except the 1394 
> stuff, that kernel didn't have it built in yet.
> 
> reboot to 2.6.11+bk-ieee1394.patch  everything works flawlessly
> 
> reboot to 2.6.11.1+bk-ieee1394.patch everything works flawlessly
> 
> reboot to 2.6.11.2+bk-ieee1394.patch tvtime has no volume control, and 
> the sound gets very very tinny about 1 second after it starts
> 
> This scenario continues up to and includeing 2.6.11.4.
> 
> So now my next question is, how to I clean up those src trees so that 
> a diff actually outputs only the src code differences, thereby 
> allowing a simple diff -urN (or whatever is the recommended command 
> line to do a recursive diff on the whole maryann) to disclose the 
> real diffs.  In other words, is a simple 'make clean' sufficient?
> 
> I got the impression from a comment that was made, that quite a body 
> of work was actually done, in the i2c area, that somehow does not 
> show in the changelog, nor in that simple little 10 line patch that 
> was 2.6.11.2.  And how that little patch could be responsible for 
> breaking this boggles what tiny little miniscule piece of a mind I 
> have left at this point.
> 
> If thats the case, then how did it get into my src code tree since the 
> exact same 2.6.11.tar.gz was used as the base for applying each of 
> the incrementals to each of the src trees I now have sitting 
> in /usr/src?  Good question that...
> 
> Unforch, the 2.6.11 plain tree has not, in this case been built yet as 
> it got accidently nuked by a missfire of my 'buildit26' script, which 
> normally moves a base version tree out of the way before it unpacks a 
> fresh copy, and then renames that tree to be the current version and 
> then restores the base tree to its original name.
> 
> Thats not the one I want to use as the 'gold standard' anyway. 
> 2.6.11.1 works, and 2.6.11.2 doesn't.  So at this point, 2.6.11.1 is 
> the 'gold standard'.
> 
> But, both the 2.6.11.1 and the 2.6.11.2 trees are as built, and the
> diff I got was far larger than forgetting to apply the 
> bk-ieee1394.patch to one of them would account for.  Many tens of 
> kilobytes in fact.
> 
> Please throw me a bone here folks.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

--------------020606040400080502020304
Content-Type: text/plain;
 name="patch.exclude"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch.exclude"

*.o
*.i
.*
*.*~
*~
*.rej
*.orig
*.orig.*
#*
*#
*.ver
ETAGS
TAGS
tags
*.map
*.s
*.a
*X
*Y

*.*X
*.*Y
SCCS
CVS
*.*,*
dwarf2-defs.h
kconfig
configs.c
defconfig
mkdep
split-include
tkparse
vmlinux
consolemap_deftbl.c
tkparse.c
classlist.h
crc32table.h
devlist.h
config
autoconf.h
compile.h
version.h
kconfig.tk
soundmodem
defkeymap.c
patest
asm
boot
conmakehash
gen-devlist
modversions.h
elfconfig.h
asm_offsets.h
*.old
cscope.*
*.so
gen_crc32table
docproc
fixdep
kallsyms
mk_elfconfig
modpost
pnmtologo
initramfs_data.*
gen_init_cpio


--------------020606040400080502020304--

