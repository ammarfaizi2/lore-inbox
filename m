Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291838AbSBXXPY>; Sun, 24 Feb 2002 18:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291840AbSBXXPN>; Sun, 24 Feb 2002 18:15:13 -0500
Received: from jalon.able.es ([212.97.163.2]:63149 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S291838AbSBXXPE>;
	Sun, 24 Feb 2002 18:15:04 -0500
Date: Mon, 25 Feb 2002 00:14:55 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: rwhron@earthlink.net
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET] Linux 2.4.18-rc3-jam1
Message-ID: <20020225001455.A1894@werewolf.able.es>
In-Reply-To: <20020224150044.GA11858@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020224150044.GA11858@rushmore>; from rwhron@earthlink.net on dom, feb 24, 2002 at 16:00:44 +0100
X-Mailer: Balsa 1.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

First of all, I never expected this tniny patch collection would origin
such "rivers of e-ink"...
Please, have always present that I can have made some mistake in my
offset re-engineering. But the fact that it at least survives the tests
is good. 

On 20020224 rwhron@earthlink.net wrote:
>2.4.18-rc2-jam1   128  0.80  5.72%    0.190       3.68  0.00000  0.00000  14
>2.4.18-rc4-jam1   128  0.80  5.72%    5.025    6734.19  0.07560  0.00000  14

This is really strange. I have looked at my patches and are the same. What
changed in mainlaine ??

[...]
>
>Below is a snippet of tiobench on random writes.  The rc4-jam1
>included the entire patchset, whereas rc2-jam1 had patches with
>the first two digits < 20.
>

So rc2-jam1 is running without the ide-update (I noticed your system is IDE),
but also without irqrate.
I will reorder the patches so you can apply 0*, 1* and 3* without problems,
then scsi-ide updates. And you can try with/out the ide update.
Do not see what can be related with latency in >=20*, apart from ide and
irqrate...

I do not know if you are already doing this, but I will skip the bproc part
for thins tests. It pollutes system calls with hooks for network, so it can
be hurting in many ways.

I will release a -jam2 with latest vm-27 and reordering the patches.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.18-rc4-jam1 #1 SMP Sat Feb 23 16:25:56 CET 2002 i686
