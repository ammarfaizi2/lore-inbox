Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262620AbSJIXkY>; Wed, 9 Oct 2002 19:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbSJIXkY>; Wed, 9 Oct 2002 19:40:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61108 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262620AbSJIXkX>;
	Wed, 9 Oct 2002 19:40:23 -0400
Date: Wed, 09 Oct 2002 16:38:53 -0700 (PDT)
Message-Id: <20021009.163853.11929697.davem@redhat.com>
To: torvalds@transmeta.com
Cc: thockin@hockin.org, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.41 s390 (8/8): 16 bit uid/gids.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210091609570.9234-100000@home.transmeta.com>
References: <200210092243.g99MhZ701270@www.hockin.org>
	<Pine.LNX.4.44.0210091609570.9234-100000@home.transmeta.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Wed, 9 Oct 2002 16:12:39 -0700 (PDT)
   
   Make a CONFIG_xxx option that means what s390 wants it to mean, and no, 
   I'm not going to accept it if you #define that by hand in some .c file. It 
   needs to be in the architecture config file, like all the other config 
   options.

I understand what you want.

He's just trying to kill all this duplicate code we have on
s390x/ppc64/sparc64/etc. which does UID16 stuff for the 32-bit
compat case 

So maybe what you're saying is some "asm/uid16.h" that
conditionalizes?

