Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317431AbSFNEaF>; Fri, 14 Jun 2002 00:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317730AbSFNEaD>; Fri, 14 Jun 2002 00:30:03 -0400
Received: from pizda.ninka.net ([216.101.162.242]:35812 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317431AbSFNEaB>;
	Fri, 14 Jun 2002 00:30:01 -0400
Date: Thu, 13 Jun 2002 21:25:28 -0700 (PDT)
Message-Id: <20020613.212528.08026527.davem@redhat.com>
To: rml@mvista.com
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4-ac: sparc64 support for O(1) scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1023996118.4800.75.camel@sinai>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Robert Love <rml@mvista.com>
   Date: 13 Jun 2002 12:21:58 -0700
   
   Patch is against 2.4.19-pre10-ac2, please apply.
   
Ummm what is with all of those switch_mm() hacks?  Is this an attempt
to work around the locking problems?  Please don't do that as it is
going to kill performance and having ifdef sparc64 sched.c changes is
ugly to say the least.

Ingo posted the correct fix to the locking problem with the patch
he posted the other day, that is what should go into the -ac patches.
