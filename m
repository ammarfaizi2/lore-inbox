Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290687AbSBLBeq>; Mon, 11 Feb 2002 20:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290701AbSBLBeh>; Mon, 11 Feb 2002 20:34:37 -0500
Received: from pizda.ninka.net ([216.101.162.242]:42118 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290687AbSBLBeV>;
	Mon, 11 Feb 2002 20:34:21 -0500
Date: Mon, 11 Feb 2002 17:32:36 -0800 (PST)
Message-Id: <20020211.173236.08323394.davem@redhat.com>
To: davidm@hpl.hp.com
Cc: anton@samba.org, linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: thread_info implementation
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <15464.28196.894340.327685@napali.hpl.hp.com>
In-Reply-To: <200202120101.g1C11OJZ010115@napali.hpl.hp.com>
	<20020211.170709.118972278.davem@redhat.com>
	<15464.28196.894340.327685@napali.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Mosberger <davidm@hpl.hp.com>
   Date: Mon, 11 Feb 2002 17:21:40 -0800
   
   The task pointer lives in the thread pointer register (r13), so it's
   trivial to address off of it.

So why don't you put the, oh my gosh, "THREAD INFO POINTER" into the
thread pointer register instead?  That is what I did and everything
transforms naturally, you will need to make zero modifications to
assembly code besides the offset macro names and that you can even
script :-)

