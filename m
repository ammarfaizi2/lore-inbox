Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265749AbTIERap (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265751AbTIERao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:30:44 -0400
Received: from colin2.muc.de ([193.149.48.15]:41476 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265749AbTIERan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:30:43 -0400
Date: 5 Sep 2003 19:30:39 +0200
Date: Fri, 5 Sep 2003 19:30:39 +0200
From: Andi Kleen <ak@colin2.muc.de>
To: Andreas Jaeger <aj@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>, akpm@osdl.org,
       rth@redhat.com, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
Message-ID: <20030905173039.GB80302@colin2.muc.de>
References: <Pine.LNX.4.44.0309050735570.25313-100000@home.osdl.org> <ho65k76z9v.fsf@byrd.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ho65k76z9v.fsf@byrd.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You have to options:
> - use attribute ((used)) (implemented since GCC 3.2) to tell GCC that
>   a function/variable should never be removed
> - use -fno-unit-at-a-time.

Another problem is the way 32bit emulation is implemented in many 
64bit ports (all copying from sparc64) and now unified. This assumes 
an ordering between global functions and global assembly too. 

Not for i386 though. I think Andrew has already done some cleanups
in this area recently too, but it may still be dubious.

-Andi
