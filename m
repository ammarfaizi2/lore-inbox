Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266650AbUGVH6J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266650AbUGVH6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 03:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbUGVH6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 03:58:09 -0400
Received: from mailgate.pit.comms.marconi.com ([169.144.68.6]:18840 "EHLO
	mailgate.pit.comms.marconi.com") by vger.kernel.org with ESMTP
	id S266650AbUGVH6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 03:58:05 -0400
Message-ID: <313680C9A886D511A06000204840E1CF08F43050@whq-msgusr-02.pit.comms.marconi.com>
From: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
To: crossgcc <crossgcc@sources.redhat.com>
Cc: "'Hollis Blanchard'" <hollisb@us.ibm.com>,
       "'bertrand marquis'" <bertrand_marquis@yahoo.fr>,
       "'trevor_scroggins@hotmail.com'" <trevor_scroggins@hotmail.com>,
       "'Dan Kegel'" <dank@kegel.com>,
       "'Geert Uytterhoeven'" <geert@linux-m68k.org>,
       "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: No rule to make target `net/ipv4/netfilter/ipt_ecn.o'
Date: Thu, 22 Jul 2004 03:57:14 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Geert Uytterhoeven wrote:
>Re: missing elf.h (for mk_elfconfig.c)  while  building zIma ge for PPC on
Intel platform (windows XP) using cygwin
>/usr/include is the correct location, though. Did you install libelf-dev
under Cygwin?

I just did

Dan  Kegel wrote: 
>In other words, download and install
>   http://www.gnu.org/directory/libs/misc/libelf.html
>which will I think provide <gelf.h>;
>you can then make an elf.h that just does
>   #include <gelf.h>
>and you should be good to go.  (I haven't tried it myself.)
>- Dan   

I created such elf.h file and placed it into /usr/include under Cygwin in Z:

It works (the problem is solved) - so consider it to be tested now !

Thanks to everyone for help !
Best Regards,
Alex

PS But the compilation did not complete, the next error is:

make[3]: *** No rule to make target
 `net/ipv4/netfilter/ipt_ecn.o', needed by `net/ipv4/netfilter/built-in.o'.
Stop.
make[2]: *** [net/ipv4/netfilter] Error 2
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2
 
