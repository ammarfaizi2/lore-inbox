Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314057AbSDKNvm>; Thu, 11 Apr 2002 09:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314058AbSDKNvl>; Thu, 11 Apr 2002 09:51:41 -0400
Received: from imhotep.hursley.ibm.com ([194.196.110.14]:13011 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314057AbSDKNvl>; Thu, 11 Apr 2002 09:51:41 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: frankeh@watson.ibm.com
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de,
        pwaechtler@loewe-Komp.de
Subject: Re: [PATCH] Futex Generalization Patch 
In-Reply-To: Your message of "Wed, 10 Apr 2002 16:14:36 -0400."
             <20020410211348.AB5E93FE06@smtp.linux.ibm.com> 
Date: Thu, 11 Apr 2002 23:55:05 +1000
Message-Id: <E16vf2X-0001ER-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020410211348.AB5E93FE06@smtp.linux.ibm.com> you write:
> --) There is more overhead in the wakeup and the wait because I need to 
>      move from the fd to the filestruct which is always some lookup and
>      I have to verify that the file descriptor is actually a valid /dev/futex
>      file (yikes).    

Hmmm... verify on the FUTEX_AWAIT: you can maybe hold the struct file
directly (or maybe not).

> In FUTEX_AWAIT  inteprest it as { short fd, short sig };
> There should be no limitation by casting it to shorts ?

No, that's bad.  But I thought there was already a way to set what
signal occurred instead of SIGIO.  Is that not per-fd?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
