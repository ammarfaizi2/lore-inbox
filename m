Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316567AbSFEXTp>; Wed, 5 Jun 2002 19:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316568AbSFEXTo>; Wed, 5 Jun 2002 19:19:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:63884 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316567AbSFEXTn>;
	Wed, 5 Jun 2002 19:19:43 -0400
Date: Wed, 05 Jun 2002 16:13:42 -0700 (PDT)
Message-Id: <20020605.161342.71552259.davem@redhat.com>
To: bcrl@redhat.com
Cc: lord@sgi.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [RFC] 4KB stack + irq stack for x86
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020605183152.H4697@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Benjamin LaHaise <bcrl@redhat.com>
   Date: Wed, 5 Jun 2002 18:31:52 -0400

   On Wed, Jun 05, 2002 at 05:15:23PM -0500, Steve Lord wrote:
   > Just what are the tasks you normally run - and how many code
   > paths do you think there are out there which you do not run. XFS
   > might get a bit stack hungry in places, we try to keep it down,
   > but when you get into file system land things can stack up quickly:
   
   You already lose in that case today, as multiple irqs may come in 
   from devices and eat up the stack.

I agree with Ben, if things explode due to stack overflow with his
changes they are almost certain to explode before his changes.
