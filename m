Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVAJXWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVAJXWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 18:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbVAJXTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 18:19:49 -0500
Received: from [195.110.122.101] ([195.110.122.101]:50346 "EHLO
	cadalboia.ferrara.linux.it") by vger.kernel.org with ESMTP
	id S262545AbVAJWiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 17:38:18 -0500
From: Simone Piunno <pioppo@ferrara.linux.it>
To: LM Sensors <sensors@stimpy.netroedge.com>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Date: Mon, 10 Jan 2005 23:41:43 +0100
User-Agent: KMail/1.7.2
Cc: Jonas Munsin <jmunsin@iki.fi>, djg@pdp8.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
References: <200501080150.44653.pioppo@ferrara.linux.it> <20050108103449.345def67.khali@linux-fr.org>
In-Reply-To: <20050108103449.345def67.khali@linux-fr.org>
X-Key-URL: http://members.ferrara.linux.it/pioppo/mykey.asc
X-Key-FP: 9C15F0D3E3093593AC952C92A0CD52B4860314FC
X-Key-ID: 860314FC/C09E842C
X-Message: GnuPG/PGP5 are welcome
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501102341.44949.pioppo@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 January 2005 10:34, Jean Delvare wrote:

> Could you please provide a dump of your it87 chip before loading the
> it87 driver? "isadump 0x295 0x296" should tell you. I would also be
> interested in a dump right after you load the driver if possible 

Before loading it87:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 00 00 00 37 ff 00 37 ff 07 00 5b 00 2a ff ff
10: ff ff ff 30 00 00 00 00 00 00 00 00 00 00 00 00
20: 5c 9f ce b0 bf b2 83 aa 00 19 29 7f 00 00 00 00
30: ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
40: 7f 7f 7f 7f 7f 7f 00 00 2d 00 00 00 00 00 00 00
50: ff 38 7f 7f 7f 00 00 00 90 4f 06 00 50 00 00 00
60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
70: 7f 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00
80: 11 00 00 00 37 ff 00 37 ff 07 00 5b 00 2a ff ff
90: ff ff ff 30 00 00 00 00 00 00 00 00 00 00 00 00
a0: 5c 9f ce b0 bf b2 83 aa 00 19 29 7f 00 00 00 00
b0: ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00 ff 00
c0: 7f 7f 7f 7f 7f 7f 00 00 2d 00 00 00 00 00 00 00
d0: ff 38 7f 7f 7f 00 00 00 90 4f 06 00 50 00 00 00
e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
f0: 7f 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00

After loading it87:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 11 03 60 00 37 ff 00 37 ff 07 00 5b 00 ff ff ff
10: fe fe fe 31 07 7f 00 00 00 00 00 00 00 00 00 00
20: 5c 9f ce b2 be a9 69 ac 00 19 26 7f 00 00 00 00
30: 62 4d a4 94 d9 c4 c3 b1 c5 b2 82 78 80 79 cd a7
40: 28 0f 2d 0f 2d 0f 00 00 2d 00 00 00 00 00 00 00
50: ff 38 7f 7f 7f 00 00 00 90 4f 06 00 50 00 00 00
60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
70: 7f 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00
80: 11 00 00 00 37 ff 00 37 ff 07 00 5b 00 ff ff ff
90: fe fe fe 31 07 7f 00 00 00 00 00 00 00 00 00 00
a0: 5c 9f ce b2 be a9 69 ac 00 19 26 7f 00 00 00 00
b0: 62 4d a4 94 d9 c4 c3 b1 c5 b2 82 78 80 79 cd a7
c0: 28 0f 2d 0f 2d 0f 00 00 2d 00 00 00 00 00 00 00
d0: ff 38 7f 7f 7f 00 00 00 90 4f 06 00 50 00 00 00
e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
f0: 7f 7f 7f 7f 7f 00 00 00 00 00 00 00 00 00 00 00

> (but don't burn your CPU for me).

Oh, don't worry.
I've already coded a small fan controller daemon working around the problem 
and driving the fan to run at the minimum speed sufficient to keep the CPU 
cool enough.  Anyone interested can look here:
  http://svn.ferrara.linux.it/view/just4fan
or check it out from the subversion repository:
  svn checkout http://svn.ferrara.linux.it/just4fan
In fact, now I run the system with it87 always loaded... it's soooo quiet!  
Now that I'm used to this silence I can't live without it: I can't stand the 
fan screaming anymore!  I think for I won't move away from -mm until this 
single feature makes it into vanilla :)

> Do you know what kind of it87 chip you do have? There are three of them,
> IT8705F, IT8712F and a SIS950 clone (mostly similar to the IT8705F).

I'm sorry I don't know.  How I could check?

Thanks again
/Simone

-- 
http://thisurlenablesemailtogetthroughoverzealousspamfilters.org
