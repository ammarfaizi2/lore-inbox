Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264052AbTEGP1Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTEGP1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:27:16 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23939 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264052AbTEGP1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:27:14 -0400
Date: Wed, 07 May 2003 07:31:55 -0700 (PDT)
Message-Id: <20030507.073155.118606464.davem@redhat.com>
To: george@mvista.com
Cc: sam@ravnborg.org, akpm@zip.com.au, kbuild-devel@lists.sourceforge.net,
       mec@shout.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic magic
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EB92747.2070204@mvista.com>
References: <3EB92176.8010803@mvista.com>
	<20030507.070646.54208027.davem@redhat.com>
	<3EB92747.2070204@mvista.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: george anzinger <george@mvista.com>
   Date: Wed, 07 May 2003 08:33:27 -0700
   
   Rather I was interested in introducing a scaled math header.  It
   would contain routines to allow access to the 64 bit mpy and div
   instructions, which ,of course, can be done in C but, if you don't 
   want the 64-bit lib, must be done with a rather large bit of code to 
   do simple s32=s64/s32 and s32=s64%s32 calculations.  And, on 64-bit 
   archs the whole problem goes away.

I think you want to do something more like what the byteorder swabbing
interfaces do.  Let the arch override whatever it'd like to optimize,
but provide default 32-bit/64-bit centric "implementations" under
linux/scaled_math/
