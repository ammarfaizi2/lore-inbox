Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751210AbVKWQZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbVKWQZK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVKWQZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:25:09 -0500
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:485 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S1751210AbVKWQZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:25:07 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17284.38866.189529.510004@gargle.gargle.HOWL>
Date: Wed, 23 Nov 2005 19:24:50 +0300
To: moreau francis <francis_moreau2000@yahoo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Use enum to declare errno values
In-Reply-To: <20051123160542.71232.qmail@web25812.mail.ukl.yahoo.com>
References: <17284.37107.573883.328659@gargle.gargle.HOWL>
	<20051123160542.71232.qmail@web25812.mail.ukl.yahoo.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

moreau francis writes:
 > 

[...]

 > hmm, are you sure that debuggers will tell you that foo returns
 > LEFT/RIGHT but not any integer value ?

No. This is not about debugging, this is about typing.

 > 
 > I just give a try and unfortunately you seem to be wrong here:

I am not, as I never claimed this. :-)

 > 
 > """"
 > (gdb) s
 > foo (x=1) at enum_test.c:8
 > 8               if (x & 0x1)
 > (gdb) finish
 > Run till exit from #0  foo (x=1) at enum_test.c:8
 > 0x0804837c in main (argc=1, argv=0xbfe14dc4) at enum_test.c:17
 > 17              return foo(1);
 > Value returned is $1 = 0
 > (gdb)

(gdb) p (enum side)$1
$2 = LEFT

(This works when debugging information about enum was stored in ELF
object.)

Nikita.
