Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbTFXWiu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 18:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbTFXWiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 18:38:50 -0400
Received: from [203.149.0.18] ([203.149.0.18]:28385 "EHLO
	krungthong.samart.co.th") by vger.kernel.org with ESMTP
	id S262297AbTFXWis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 18:38:48 -0400
Message-ID: <3EF8D6A2.20600@thai.com>
Date: Wed, 25 Jun 2003 05:54:26 +0700
From: Samphan Raruenrom <samphan@thai.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030320
X-Accept-Language: th,en-us, en
MIME-Version: 1.0
To: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org, hpa@zytor.com, Tc1000-linux@handhelds.org
Subject: Re: Crusoe's performance on linux?
References: <3EF1E6CD.4040800@thai.com> <20030619200308.A2135@ucw.cz> <3EF2144D.5060902@thai.com> <20030619221126.B3287@ucw.cz> <3EF67AD4.4040601@thai.com> <20030623102623.A18000@ucw.cz> <3EF74DBF.6000703@thai.com> <Pine.LNX.4.53.0306231821480.17484@twinlark.arctic.org> <Pine.LNX.4.53.0306232128430.9041@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.53.0306232128430.9041@twinlark.arctic.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >>The time used to compile 2.4.21 kernel off the same .config
>>Desktop - Pentium III 1 G Hz 756 MB		->	10.x min.
>>Tablet PC - Crusoe TM5800 1 GHz 733 MB	->	17.x min.

  > how much real memory are in these boxes?  the above don't look like any
  > real memory sizes i'm aware of

I copy the number from the 'total' column after free -m. They're
about 256x3 with Crusoe gave about 24M to CMS (I guess).

I tried the tests again with swapoff, on tmpfs, on disks, the result
are approximately the same. The 'kernel' used for compilation and
the setting are exactly the same (2.4.21-ac1). The 'kernel' used to run the
test and the setting are about the same (2.4.21-ac1 vs ac2).
The desktop is Red Hat 8, gcc 3.2. The TPC is Red Hat 9, gcc 3.2.

So the result are real, no disk speed related. What do you think?
I can't look at the running CMS or the translation cache so I don't know 
what
it is doing but I guess that after several run of gcc+as+ld,
the CMS still decide to interpret most part of their x86 code.

Am I wrong?
Or that TM5800 is already running as fast as possible? (from tcache)

