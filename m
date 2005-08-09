Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964889AbVHIRPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964889AbVHIRPF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 13:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbVHIRPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 13:15:05 -0400
Received: from [193.151.93.131] ([193.151.93.131]:39183 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S964889AbVHIRPE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 13:15:04 -0400
From: Thomas Habets <thomas@habets.pp.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Kernels Out Of Memoy(OOM) killer Problem ?
Date: Tue, 9 Aug 2005 19:14:20 +0200
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au, torvalds@osdl.org
References: <42F8720D.4060300@picsearch.com> <200508091655.50383.thomas@habets.pp.se> <1123605588.15600.37.camel@localhost.localdomain>
In-Reply-To: <1123605588.15600.37.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200508091914.21302.thomas@habets.pp.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: Patch removes incorrect documentation. Correct documentation
already exists in tree.

Once upon a midnight dreary, Alan Cox pondered, weak and weary:
> > > 0 - overcommit except if something is obviously silly
> > > 1 - overcommit always (some scientific workloads)
> > > 2 - don't overcommit (databases etc)
> > Exactly. Which is what the code and D/sysctl/vm.txt say, and why the
> > description in D/filesystems/proc.txt is a lying POS that needs to be
> > *shining blue led in everyones eyes* Exterminated before more people are
> > sucked into its world of lies.
> Please submit a patch to fix it

...
Kind of what I did (and changed the subject line to include PATCH). Albeit as an attachment.
This time I fought with my mail client and won. See below sig.

I found no maintainer for the documentation, did I forget to CC someone?

---------
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.pp.se" };
  char kernel[]    = { "Linux" };
  char *pgpKey[]   = { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] = { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;


diff -uprN linux-2.6.12.4.orig/CREDITS linux-2.6.12.4/CREDITS
--- linux-2.6.12.4.orig/CREDITS 2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4/CREDITS      2005-08-09 11:21:53.000000000 +0200
@@ -1267,6 +1267,12 @@ E: ehaase@inf.fu-berlin.de
 W: http://www.inf.fu-berlin.de/~ehaase
 D: Driver for the Commodore A2232 serial board
 
+N: Thomas Habets
+E: thomas@habets.pp.se
+W: http://www.habets.pp.se/
+D: Reader of code, slayer of wrongful documentation
+P: 1024D/AD48E854 A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854
+
 N: Bruno Haible
 E: haible@ma2s2.mathematik.uni-karlsruhe.de
 D: SysV FS, shm swapping, memory management fixes
diff -uprN linux-2.6.12.4.orig/Documentation/filesystems/proc.txt linux-2.6.12.4/Documentation/filesystems/proc.txt
--- linux-2.6.12.4.orig/Documentation/filesystems/proc.txt      2005-08-05 09:04:37.000000000 +0200
+++ linux-2.6.12.4/Documentation/filesystems/proc.txt   2005-08-09 11:16:13.000000000 +0200
@@ -1240,16 +1240,7 @@ swap-intensive.
 overcommit_memory
 -----------------
 
-This file  contains  one  value.  The following algorithm is used to decide if
-there's enough  memory:  if  the  value of overcommit_memory is positive, then
-there's always  enough  memory. This is a useful feature, since programs often
-malloc() huge  amounts  of  memory 'just in case', while they only use a small
-part of  it.  Leaving  this value at 0 will lead to the failure of such a huge
-malloc(), when in fact the system has enough memory for the program to run.
-
-On the  other  hand,  enabling this feature can cause you to run out of memory
-and thrash the system to death, so large and/or important servers will want to
-set this value to 0.
+See Documentation/sysctl/vm.txt.
 
 nr_hugepages and hugetlb_shm_group
 ----------------------------------

