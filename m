Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131483AbRDFLiz>; Fri, 6 Apr 2001 07:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131484AbRDFLip>; Fri, 6 Apr 2001 07:38:45 -0400
Received: from belcebu.upc.es ([147.83.2.63]:6353 "EHLO belcebu.upc.es")
	by vger.kernel.org with ESMTP id <S131483AbRDFLie>;
	Fri, 6 Apr 2001 07:38:34 -0400
Message-ID: <3ACD9D91.377B@mat.upc.es>
Date: Fri, 06 Apr 2001 12:42:25 +0200
From: Francesc Oller <francesc@mat.upc.es>
Reply-To: francesc@mat.upc.es
Organization: UPC
X-Mailer: Mozilla 3.01 (Win95; I)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: A fork-like C-wrapper for clone()?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

is there a fork-like C-wrapper for clone which would let write
something like:

  if ((pid=clone(0,SIGCHLD|CLONE_VM))==0) /* child */
    {
      child_code;
      _exit(0);
    }
  else
    {
      assert(pid>0); /* mother */
      mother_code;
      exit(0);
    }

I'm not thinking in glibc'__clone or Linus' clone.c example since
they encapsulate the main thread code in a function. (i.e. not
fork-like)

Can somebody point me to some sample code?

I'll thank a CC to my e-mail

cheers

Francesc Oller
