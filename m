Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289446AbSAJN6O>; Thu, 10 Jan 2002 08:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289449AbSAJN6E>; Thu, 10 Jan 2002 08:58:04 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2432 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289446AbSAJN5y>;
	Thu, 10 Jan 2002 08:57:54 -0500
Date: Thu, 10 Jan 2002 05:56:51 -0800 (PST)
Message-Id: <20020110.055651.74749601.davem@redhat.com>
To: david.balazic@uni-mb.si
Cc: matthias.andree@stud.uni-dortmund.de, linux-kernel@vger.kernel.org
Subject: Re: Simple local DOS
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C3D9B2B.2DDB72CB@uni-mb.si>
In-Reply-To: <3C3D9B2B.2DDB72CB@uni-mb.si>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: David Balazic <david.balazic@uni-mb.si>
   Date: Thu, 10 Jan 2002 14:46:19 +0100
   
   > all this is off-topic on linux-kernel,
   
   non-root user locked up the console code. console code is part of kernel.
   it is a kernel topic.

The real issue is that X has the console in an indeterminate state (it
probably just saved the VGA state and is outputting probing
information) but now it is blocked on terminal output due to the
"less".

There is nothing the kernel can do about what X is up to.  The suid
wrapper for X can check if stdout/stderr is a pipe and refuse to run
if it is.

So really, it is in fact off topic for linux-kernel.  Please take this
to the xfree86 lists, I'm sure they'll be more than happy to fix it.

Franks a lot,
David S. Miller
davem@redhat.com
