Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263038AbRFEAeu>; Mon, 4 Jun 2001 20:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbRFEAel>; Mon, 4 Jun 2001 20:34:41 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:10500 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S263038AbRFEAe1>; Mon, 4 Jun 2001 20:34:27 -0400
Date: Mon, 4 Jun 2001 18:36:42 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: TRG vger.timpanogas.org hacked
Message-ID: <20010604183642.A855@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Our master server (vger.timpanogas.org) running 2.2.19 was hacked and 
completely obliterated by someone using a Novell Proxy Cache via a kernel
level exploit in [sys_wait+4].  They somehow created a segmentation fault 
down inside the kernel, then gained access to the /lib directory and 
relinked the libraries to a set of bogus libs, which gave them 
access to the server.  Only public code and email is processed on 
this server.  

For those interested in reviewing this attack, I have the entire previous
hard disk available and can mount it under the public ftp area if anyone 
is curious as to how these folks did this.  They exploited BIND 8.2.3
to get in and logs indicated that someone was using a "back door" in 
Novell's NetWare proxy caches to perform the attack (since several 
different servers were used as "blinds" to get in).  

We are unable to determine just how they got in exactly, but they 
kept trying and created an oops in the affected code which allowed 
the attack to proceed.  

Jeff

