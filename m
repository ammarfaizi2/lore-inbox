Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSDJQeq>; Wed, 10 Apr 2002 12:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313309AbSDJQep>; Wed, 10 Apr 2002 12:34:45 -0400
Received: from [62.221.7.202] ([62.221.7.202]:62602 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S313305AbSDJQeo>; Wed, 10 Apr 2002 12:34:44 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: frankeh@watson.ibm.com
Cc: linux-kernel@vger.kernel.org, Martin.Wirth@dlr.de, pwaechler@loewe-Komp.de,
        drepper@redhat.com
Subject: Re: [PATCH] Futex Generalization Patch 
In-Reply-To: Your message of "Wed, 10 Apr 2002 10:24:42 -0400."
             <20020410152354.169FF3FE06@smtp.linux.ibm.com> 
Date: Thu, 11 Apr 2002 02:37:57 +1000
Message-Id: <E16vL6l-00083d-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020410152354.169FF3FE06@smtp.linux.ibm.com> you write:
> Enclosed is an "asynchronous" extension to futexes.

Wow... I never thought of that.  Cool!

My main concern is the DoS of multiple kmallocs.  Alan Cox suggested
tying it to an fd (ie. naturally limited), and I think this might work
(I don't know much about async io).  ie. (int)utime is the fd to wake
up, and then it can be used for async io OR a poll/select interface
using existing infrastructure.

Probably it has to be a special fd (/dev/futex?).

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
