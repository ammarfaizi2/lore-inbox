Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261828AbULCBDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbULCBDL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 20:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbULCBDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 20:03:11 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:62090 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261828AbULCBDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 20:03:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HzdRcyqjOnTKy4Kou80xkxt26LkagziibY8l5du9Ae1hy0i1+B/e0Z9e7bovOIVTXI58vyipgP6/meuHKmiWBItKPan6jdMUGs/lMwK7dqoMt6zZL4QQTonLqWNTGt6ehHSPTcoY5D1F+srLKegrkWjZbxEcdTWCvl+92OB/3RI=
Message-ID: <abc3398204120217031640ba07@mail.gmail.com>
Date: Thu, 2 Dec 2004 19:03:06 -0600
From: John Newman <cachehit@gmail.com>
Reply-To: John Newman <cachehit@gmail.com>
To: Chris Wright <chrisw@osdl.org>
Subject: Re: kernel crashes with 2.5/2.8
Cc: linux-kernel@vger.kernel.org, mhenderson@pointserve.com
In-Reply-To: <20041201111617.M14339@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <abc339820412010909325c08b6@mail.gmail.com>
	 <20041201111617.M14339@build.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I got some time this evening to run memtest86.  With the 2650
configured with 2 1GB sticks memtest86 started reprting errors almost
immediately.  "Terrfic!" I thought, "this is my problem!"  The address
seemed suspicious though:  0007ffedc80 (2047.8MB) is where all the
errors were reported.  I decided to let it run all the way through but
it froze at 34% of the first test.  Memtest86 also said it did not
support this chipset when I tried to dink with advanced options.

So, I replaced the ram with 4 512MB sticks I had laying around from a
different Dell machine.  I booted memtest86 again and what do you
know.... errors @ 0007ffedc80, with completely different RAM.  So
obviously these results are fishy.

Someone replied to me off-list and said the only way they could get
their Dell 2650 stable was by running 2.4.28.

--
john


On Wed, 1 Dec 2004 11:16:17 -0800, Chris Wright <chrisw@osdl.org> wrote:
> * John Newman (cachehit@gmail.com) wrote:
> > Nov 24 21:34:10 ptscorp-nis01 kernel: Unable to handle kernel paging
> > request at virtual address 01000004
> 
> Possible bad memory.  This could be 4 byte offset of NULL with one bit
> flipped.  Have you run memtest86?
> 
> Also, it'd be useful to keep tabs on the Oopsen.  Are they totally
> random, same location, etc.
> 
> thanks,
> -chris
> 


-- 
John
