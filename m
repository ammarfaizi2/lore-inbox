Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316037AbSEJQA6>; Fri, 10 May 2002 12:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316045AbSEJQA5>; Fri, 10 May 2002 12:00:57 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61888 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316037AbSEJQAy>;
	Fri, 10 May 2002 12:00:54 -0400
Date: Fri, 10 May 2002 08:48:09 -0700 (PDT)
Message-Id: <20020510.084809.119196581.davem@redhat.com>
To: gilbertd@treblig.org
Cc: dizzy@roedu.net, linux-kernel@vger.kernel.org
Subject: Re: mmap, SIGBUS, and handling it
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3CDBED93.3040508@treblig.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
   Date: Fri, 10 May 2002 16:56:03 +0100

   David S. Miller wrote:
   > How would you like the kernel to "ignore" a page fault that cannot be
   > serviced?
   
   Well imagining you really wanted to do it you could skip a store 
   instruction or put a dummy value in the register that something is being 
   loaded into.

What is a suitable dummy value?  Zero?  That would likely lead to a
segfault if the value being loaded is supposed to be some pointer.

There is no reasonable behavior other than to kill the process if it
has not specified it's own handler.
