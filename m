Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279655AbRJYAKS>; Wed, 24 Oct 2001 20:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279656AbRJYAKL>; Wed, 24 Oct 2001 20:10:11 -0400
Received: from jalon.able.es ([212.97.163.2]:9652 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S279652AbRJYAJx>;
	Wed, 24 Oct 2001 20:09:53 -0400
Date: Thu, 25 Oct 2001 02:10:21 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Dave McCracken <dmccr@us.ibm.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Separate CLONE_PARENT and CLONE_THREAD behavior
Message-ID: <20011025021021.A2928@werewolf.able.es>
In-Reply-To: <117830000.1003951015@baldur>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <117830000.1003951015@baldur>; from dmccr@us.ibm.com on Wed, Oct 24, 2001 at 21:16:55 +0200
X-Mailer: Balsa 1.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20011024 Dave McCracken wrote:
>
>Several versions back you added code that forces CLONE_PARENT behavior
>whenever CLONE_THREAD is specified.  This unnecesarily forces a particular
>multi-threading model at the application level, and in fact breaks some
>ways of doing multi-threading.
>
>In particular, it requires that at least one task in an application *not*
>be part of the thread group, and that the pid returned by the original
>fork() can not be the thread group id itself.
>
>It would still be entirely possible to code an application or threading
>library in the way you envision by specifying CLONE_PARENT and CLONE_THREAD
>together.  However, there's no good reason for forcing this model.
>
>A patch to remove that restriction is below.
>

Will this break current pthreads in glibc 2.2.4 ???

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.13-beo #2 SMP Thu Oct 25 00:59:08 CEST 2001 i686
