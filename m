Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWIKW5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWIKW5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 18:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWIKW5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 18:57:16 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:19930 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932305AbWIKW5Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 18:57:16 -0400
Message-Id: <200609112256.k8BMuqVt006467@laptop13.inf.utfsm.cl>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org, Rickard Faith <faith@redhat.com>
Subject: Re: [PATCH] fix warning: no return statement in function returning non-void in kernel/audit.c 
In-Reply-To: Message from Jesper Juhl <jesper.juhl@gmail.com> 
   of "Mon, 11 Sep 2006 17:15:16 +0200." <200609111715.17080.jesper.juhl@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Mon, 11 Sep 2006 18:56:52 -0400
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 11 Sep 2006 18:56:52 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
> kauditd_thread() is being used in a call to kthread_run(). kthread_run()
> expects a function returning 'int' which is also how kauditd_thread() is
> declared. Unfortunately kauditd_thread() neglects to return a value

It is an infinite loop...
>                                                                     which
> results in this complaint from gcc :

>   kernel/audit.c:372: warning: no return statement in function returning non-void

> Easily fixed by just adding a 'return 0;' to kauditd_thread().

How about marking it as never returning?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
